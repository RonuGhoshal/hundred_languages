require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:school) { create(:school) }
  let(:teacher) { create(:teacher, school: school) }
  let!(:classroom) { create(:classroom, school: school) }

  before do
    classroom.teachers << teacher
    sign_in teacher
  end

  describe "GET #index" do
    it "assigns the teacher's classrooms as @classrooms" do
      get :index
      expect(assigns(:classrooms)).to eq([ classroom ])
    end

    it "includes associated students, teachers, and classrooms_teachers" do
      get :index
      expect(assigns(:classrooms).first.association(:students).loaded?).to be true
      expect(assigns(:classrooms).first.association(:teachers).loaded?).to be true
      expect(assigns(:classrooms).first.association(:classrooms_teachers).loaded?).to be true
    end
  end
end
