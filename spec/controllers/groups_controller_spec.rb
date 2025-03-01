require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  before do
    @user = create(:user)
    sign_in @user
  end

  describe "GET #index" do
    context "with no filters" do
      it "returns a success response" do
        get :index, params: {}
        expect(response).to be_successful
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Group" do
        expect {
          post :create, params: { group: { name: "Amigo Secreto" } }
        }.to change(Group, :count).by(1)
      end

      it "renders a JSON response with the new group" do
        post :create, params: { group: { name: "Amigo Secreto" } }
        expect(response).to have_http_status(:created)
        expect(response.body).to eq({ data: Group.last, message: "Group created successfully" }.to_json)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new group" do
        post :create, params: { group: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "unauthenticated" do
      it "returns a 401 status code" do
        sign_out @user
        post :create, params: { group: { name: "Amigo Secreto
        " } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
