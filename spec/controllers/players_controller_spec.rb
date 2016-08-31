require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  let(:color) { "#fabecc" }
  let(:name) { "chiche" }

  describe "GET #new" do
    it "renders the 'new' template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do

    let(:create_request) { post :create, params: { player: { name: name, color: color } } }

    it "creates a new Player" do
      expect{ create_request }.to change{ Player.count }.by(1)
    end

    it "redirects to the index if the player was sucessfully created" do
      create_request
      expect(response).to redirect_to(root_path)
    end

    it "redirects to the 'new' page with a flash notice if the player is not valid" do
      post :create, params: { player: { name: nil, color: nil } }
      expect(response).to redirect_to(new_player_path)
      expect(flash[:notice])
    end
  end

  describe "PATCH #update" do
    let(:player) { Player.new(name: name, color: color) }

    before do
      player.save!
    end

    context "Update with correct fields" do
      before do
        put :update, params: { id: player.id, player: { name: name.capitalize, color: color.upcase } }
      end

      it "updates the player's fields" do
        player.reload
        expect(player.name).to eq name.capitalize
        expect(player.color).to eq color.upcase
      end

      it "redirects to the index if update successful" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "Update with incorrect fields" do
      it "redirects to the 'edit' page with a flash notice if the player is not valid" do
        put :update, params: { id: player.id, player: { name: nil, color: nil } }
        expect(response).to redirect_to(edit_player_path(player))
        expect(flash[:notice])
      end
    end
  end

  describe "DELETE #destroy" do
    let(:player) { Player.new(name: name, color: color) }
    let(:destroy_request) { delete :destroy, params: { id: player.id } }

    before do
      player.save!
      destroy_request
    end

    it "destroys a player" do
      expect(Player.count).to eq 0
    end

    it "redirects to the index" do
      expect(response).to redirect_to(root_path)
    end
  end
end
