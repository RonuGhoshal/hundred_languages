require 'rails_helper'

RSpec.describe InvitationsController, type: :controller do
  let(:admin) { create(:teacher, role: 'admin') }
  let(:school) { create(:school) }
  let(:valid_teacher_params) do
    {
      teachers: [
        { email_address: 'teacher100@example.com', first_name: 'John', last_name: 'Doe' },
        { email_address: 'teacher200@example.com', first_name: 'Jane', last_name: 'Smith' }
      ]
    }
  end
  let(:invalid_teacher_params) do
    {
      teachers: [
        { email_address: '', first_name: 'John', last_name: 'Doe' }
      ]
    }
  end

  before do
    admin.update(school: school)
    sign_in admin
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates invitations for teachers" do
        expect {
          post :create, params: valid_teacher_params, format: :json
        }.to change(Teacher, :count).by(2)
      end

      it "associates teachers with the admin's school" do
        post :create, params: valid_teacher_params, format: :json
        expect(Teacher.last.school).to eq(school)
      end
    end

    context "with invalid params" do
      it "does not create any teachers" do
        expect {
          post :create, params: invalid_teacher_params, format: :json
        }.not_to change(Teacher, :count)
      end

      it "returns error response" do
        post :create, params: invalid_teacher_params, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['alert']).to be_present
      end
    end

    context "with duplicate email" do
      let(:existing_teacher) { create(:teacher, email_address: 'duplicate@example.com') }
      let(:duplicate_teacher_params) do
        {
          teachers: [
            { email_address: existing_teacher.email_address, first_name: 'John', last_name: 'Doe' }
          ]
        }
      end

      before do
        existing_teacher # create the teacher with the duplicate email
      end

      it "does not create duplicate teachers" do
        expect {
          post :create, params: duplicate_teacher_params, format: :json
        }.not_to change(Teacher, :count)
      end

      it "returns error response with failure message" do
        post :create, params: duplicate_teacher_params, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['alert']).to include("Failed to invite #{existing_teacher.email_address}")
      end
    end
  end

  context "when user is not an admin" do
    let(:non_admin) { create(:teacher) }

    before do
      non_admin.update(school: school)
      sign_in non_admin
    end

    it "returns forbidden response" do
      post :create, params: valid_teacher_params, format: :json
      expect(response).to have_http_status(:forbidden)
      expect(JSON.parse(response.body)['alert']).to eq("You don't have permission to invite teachers.")
    end
  end
end
