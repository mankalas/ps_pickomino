require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "GET #show" do
    let(:game) { Game.create! }

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
end
