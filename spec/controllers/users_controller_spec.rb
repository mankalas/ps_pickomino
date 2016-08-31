require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:color) { "#fabecc" }
  let(:name) { "chiche" }

  describe "GET #new" do
    it "renders the 'new' template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do

    let(:create_request) { post :create, params: { user: { name: name, color: color } } }

    it "creates a new User" do
      expect{ create_request }.to change{ User.count }.by(1)
    end

    it "redirects to the index if the user was sucessfully created" do
      create_request
      expect(response).to redirect_to(root_path)
    end

    it "redirects to the 'new' page with a flash notice if the user is not valid" do
      post :create, params: { user: { name: nil, color: nil } }
      expect(response).to redirect_to(new_user_path)
      expect(flash[:notice])
    end
  end

  describe "PATCH #update" do
    let(:user) { User.new(name: name, color: color) }

    before do
      user.save!
    end

    context "Update with correct fields" do
      before do
        put :update, params: { id: user.id, user: { name: name.capitalize, color: color.upcase } }
      end

      it "updates the user's fields" do
        user.reload
        expect(user.name).to eq name.capitalize
        expect(user.color).to eq color.upcase
      end

      it "redirects to the index if update successful" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "Update with incorrect fields" do
      it "redirects to the 'edit' page with a flash notice if the user is not valid" do
        put :update, params: { id: user.id, user: { name: nil, color: nil } }
        expect(response).to redirect_to(edit_user_path(user))
        expect(flash[:notice])
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { User.new(name: name, color: color) }
    let(:destroy_request) { delete :destroy, params: { id: user.id } }

    before do
      user.save!
      destroy_request
    end

    it "destroys a user" do
      expect(User.count).to eq 0
    end

    it "redirects to the index" do
      expect(response).to redirect_to(root_path)
    end
  end
end
