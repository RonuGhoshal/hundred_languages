require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  let(:school) { create(:school) }
  let(:teacher) { create(:teacher, school: school) }
  let(:classroom) { create(:classroom, school: school) }
  let(:valid_attributes) { attributes_for(:classroom) }
  let(:invalid_attributes) { { name: '' } }

  before do
    sign_in teacher
  end

  describe "GET #index" do
    it "assigns all classrooms as @classrooms" do
      get :index, params: { school_id: school.id }
      expect(assigns(:classrooms)).to eq([ classroom ])
    end
  end

  describe "GET #new" do
    it "assigns a new classroom as @classroom" do
      get :new, params: { school_id: school.id }
      expect(assigns(:classroom)).to be_a_new(Classroom)
    end
  end

  describe "GET #edit" do
    it "assigns the requested classroom as @classroom" do
      get :edit, params: { id: classroom.id }
      expect(assigns(:classroom)).to eq(classroom)
    end

    it "assigns available years" do
      get :edit, params: { id: classroom.id }
      expect(assigns(:available_years)).to eq(AVAILABLE_YEARS)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Classroom" do
        expect {
          post :create, params: { school_id: school.id, classroom: valid_attributes }
        }.to change(Classroom, :count).by(1)
      end

      it "redirects to the school edit page" do
        post :create, params: { school_id: school.id, classroom: valid_attributes }
        expect(response).to redirect_to(edit_school_path(school))
      end
    end

    context "with invalid params" do
      it "does not create a new Classroom" do
        expect {
          post :create, params: { school_id: school.id, classroom: invalid_attributes }
        }.not_to change(Classroom, :count)
      end

      it "redirects to the school edit page with alert" do
        post :create, params: { school_id: school.id, classroom: invalid_attributes }
        expect(response).to redirect_to(edit_school_path(school))
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: "New Classroom Name" } }

      it "updates the requested classroom" do
        put :update, params: { id: classroom.id, classroom: new_attributes }
        classroom.reload
        expect(classroom.name).to eq("New Classroom Name")
      end

      it "redirects to the classroom" do
        put :update, params: { id: classroom.id, classroom: valid_attributes }
        expect(response).to redirect_to(classroom_path(classroom))
      end
    end

    context "with invalid params" do
      it "renders the edit template" do
        put :update, params: { id: classroom.id, classroom: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end
end
