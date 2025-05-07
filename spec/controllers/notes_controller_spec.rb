require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  let(:teacher) { create(:teacher) }
  let(:school) { create(:school) }
  let(:student) { create(:student, school: school) }
  let(:note) { create(:note, author: teacher, students: [ student ]) }
  let(:valid_attributes) { attributes_for(:note, student_ids: [ student.id ]) }

  before do
    teacher.update(school: school)
    sign_in teacher
  end

  describe "GET #index" do
    it "assigns the teacher's notes as @notes" do
      note # create the note
      get :index
      expect(assigns(:notes)).to eq([ note ])
    end

    it "includes associated students and author" do
      note # create the note
      get :index
      expect(assigns(:notes).first.association(:students).loaded?).to be true
      expect(assigns(:notes).first.association(:author).loaded?).to be true
    end
  end

  describe "GET #show" do
    it "assigns the requested note as @note" do
      get :show, params: { id: note.id }
      expect(assigns(:note)).to eq(note)
    end

    it "includes associated students and author" do
      get :show, params: { id: note.id }
      expect(assigns(:note).association(:students).loaded?).to be true
      expect(assigns(:note).association(:author).loaded?).to be true
    end
  end

  describe "GET #new" do
    it "assigns a new note as @note" do
      get :new
      expect(assigns(:note)).to be_a_new(Note)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Note" do
        expect {
          post :create, params: { note: valid_attributes }
        }.to change(Note, :count).by(1)
      end

      it "assigns the current user as the author" do
        post :create, params: { note: valid_attributes }
        expect(assigns(:note).author).to eq(teacher)
      end

      it "associates the note with the specified students" do
        post :create, params: { note: valid_attributes }
        expect(assigns(:note).students).to include(student)
      end

      it "redirects to the created note" do
        post :create, params: { note: valid_attributes }
        expect(response).to redirect_to(note_path(Note.last))
      end
    end
  end
end
