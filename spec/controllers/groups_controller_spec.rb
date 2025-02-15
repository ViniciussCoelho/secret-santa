require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
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
        expect(response.body).to eq(Group.last.to_json)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new group" do
        post :create, params: { group: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
