require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:game) { Game.create! }

  describe "GET #show" do
    it "renders the 'show' template" do
      get :show, params: { id: game.id }
      expect(response).to render_template(:show)
    end
  end

  describe "POST #create" do
    before do
      User.create(:name => "Chiche", :color => "#fabecc")
    end

    let(:create_request) { post :create, :params => { :game => { :user_ids => [1] } } }

    it "creates a new game" do
      expect{ create_request }.to change{ Game.count }.by(1)
    end

    it "redirects to the freshly created game" do
      create_request
      expect(response).to redirect_to(Game.last)
    end
  end

  describe "DELETE #destroy" do
    let(:destroy_request) { delete :destroy, :params => { :id => game.id } }

    it "destroys a game" do
      game # To actually create the game
      expect{ destroy_request }.to change{ Game.count }.by(-1)
    end
  end

  shared_examples "service call" do
    let(:request) { post action, :params => params }
    let(:player) { Player.create!(game: game, user: User.create!(name: "a")) }

    before do
      game.turns.create!(player: player)
    end

    it "calls the RollDice service" do
      mock = double(service)
      expect(service).to receive(:new).and_return(mock)
      expect(mock).to receive(:call)
      request
    end

    it "redirects to the current game page" do
      request
      expect(response).to redirect_to(game)
    end
  end

  describe "POST #roll_dice" do
    let(:action) { :roll_dice }
    let(:service) { RollDice }
    let(:params) { {:id => game.id} }

    it_behaves_like "service call"
  end

  describe "POST #pick_dice" do
    let(:action) { :pick_dice }
    let(:service) { PickDice }
    let(:params) { {:id => game.id, :value => 5 } }

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
