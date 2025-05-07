require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  let(:admin) { create(:teacher, role: 'admin') }
  let(:school) { create(:school) }
  let(:valid_attributes) { attributes_for(:school) }
  let(:invalid_attributes) { { name: '' } }

  before do
    admin.update(school: school)
    sign_in admin
  end

  describe "GET #edit" do
    it "assigns the requested school as @school" do
      get :edit, params: { id: school.id }
      expect(assigns(:school)).to eq(school)
    end

    it "assigns available years" do
      get :edit, params: { id: school.id }
      expect(assigns(:available_years)).to eq(AVAILABLE_YEARS)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: "New School Name" } }

      it "updates the requested school" do
        put :update, params: { id: school.id, school: new_attributes }
        school.reload
        expect(school.name).to eq("New School Name")
      end

      it "redirects to the root path" do
        put :update, params: { id: school.id, school: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "renders the edit template" do
        put :update, params: { id: school.id, school: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  context "when user is not an admin" do
    let(:non_admin) { create(:teacher) }

    before do
      non_admin.update(school: school)
      sign_in non_admin
    end

    it "redirects to root path with alert" do
      get :edit, params: { id: school.id }
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq("You must be an admin to perform this action.")
    end
  end
end
