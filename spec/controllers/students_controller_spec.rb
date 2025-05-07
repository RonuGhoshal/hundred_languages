require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:teacher) { create(:teacher) }
  let(:school) { create(:school) }
  let(:classroom) { create(:classroom, school: school) }
  let(:student) { create(:student, school: school) }
  let(:note) { create(:note, students: [ student ], author: teacher) }

  before do
    teacher.update(school: school)
    sign_in teacher
  end

  describe "GET #index" do
    before do
      student.classrooms << classroom
      teacher.classrooms << classroom
    end

    it "assigns all students as @students" do
      get :index
      expect(assigns(:students)).to eq([ student ])
    end

    it "includes associated classrooms" do
      get :index
      expect(assigns(:students).first.classrooms).to include(classroom)
    end

    it "includes associated teachers" do
      get :index
      expect(assigns(:students).first.teachers).to include(teacher)
    end

    it "includes active classroom" do
      student.update(active_classroom: classroom)
      get :index
      expect(assigns(:students).first.active_classroom).to eq(classroom)
    end
  end

  describe "GET #show" do
    before do
      student.classrooms << classroom
      teacher.classrooms << classroom
      note # Create the note
    end

    it "assigns the requested student as @student" do
      get :show, params: { id: student.id }
      expect(assigns(:student)).to eq(student)
    end

    it "includes associated classrooms" do
      get :show, params: { id: student.id }
      expect(assigns(:student).classrooms).to include(classroom)
    end

    it "includes associated teachers" do
      get :show, params: { id: student.id }
      expect(assigns(:student).teachers).to include(teacher)
    end

    it "includes associated notes" do
      get :show, params: { id: student.id }
      expect(assigns(:student).notes).to include(note)
    end

    it "includes active classroom" do
      student.update(active_classroom: classroom)
      get :show, params: { id: student.id }
      expect(assigns(:student).active_classroom).to eq(classroom)
    end
  end
end
