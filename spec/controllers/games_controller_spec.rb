require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  fixtures :users

  let(:user) { users(:bob) }
  let(:game) { CreateGame.new([user.id]).call }

  describe "GET #show" do
    it "renders the 'show' template" do
      get :show, :params => { :id => game.id }
      expect(response).to render_template(:show)
    end
  end

  describe "POST #create" do
    context "when the request contains no user id" do
      let(:create_request) { post :create, :params => { :game => { :user_ids => [""] } } }

      before do
        create_request
      end

      it "display an error message" do
        expect(flash[:notice]).to be_truthy
      end

      it "redirects to the 'new' page" do
        expect(response).to redirect_to(new_game_path)
      end
    end

    context "when the request contains one user" do
      let(:create_request) { post :create, :params => { :game => { :user_ids => [user.id] } } }

      it "creates a new game" do
        expect{ create_request }.to change{ Game.count }.by(1)
      end

      it "does not display an error message" do
        expect(flash[:notice]).to be_falsey
      end

      it "redirects to the freshly created game" do
        create_request
        expect(response).to redirect_to(Game.last)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:destroy_request) { delete :destroy, :params => { :id => game.id } }

    it "destroys a game" do
      game # To actually create the game
      expect{ destroy_request }.to change{ Game.count }.by(-1)
    end
  end

  describe "POST #pick_dice" do
    let(:request) { post :pick_dice, :params => { :id => game.id, :value => '5' } }

    before do
      game.turns.create!(:player => game.players.take)
      game.turns.last.rolls.create!(:outcome => "12312312")
    end

    it "calls the RollDice service" do
      mock = double(PickDice)
      expect(PickDice).to receive(:new).and_return(mock)
      expect(mock).to receive(:call)
      expect(mock).to receive(:notice)

      request
    end

    it "redirects to the current game page" do
      request
      expect(response).to redirect_to(game)
    end

    context "when the player can't pick a domino" do
      before do
        expect_any_instance_of(Turn).to receive(:can_pick_domino?).and_return(false)
        request
      end

      it "displays a message" do
        expect(flash[:notice]).to be_truthy
      end
    end

    context "when the player can pick a domino" do
      before do
        expect_any_instance_of(Turn).to receive(:can_pick_domino?).and_return(true)
        request
      end

      it "does not display a message" do
        expect(flash[:notice]).to be_falsey
      end
    end
  end

  shared_examples "service call" do
    let(:request) { post action, :params => params }

    it "calls the RollDice service" do
      mock = double(service)
      expect(service).to receive(:new).and_return(mock)
      expect(mock).to receive(:call)
      request
    end
  end

  describe "POST #roll_dice" do
    let(:action) { :roll_dice }
    let(:service) { RollDice }
    let(:params) { {:id => game.id} }

    it_behaves_like "service call"
  end

  describe "POST #pick_domino" do
    let(:action) { :pick_domino }
    let(:service) { PickDomino }
    let(:params) { {:id => game.id, :domino => 21 } }

    it_behaves_like "service call"
  end

  describe "POST #pass" do
    let(:action) { :pass }
    let(:service) { PassTurn }
    let(:params) { {:id => game.id} }

    it_behaves_like "service call"
  end
end
