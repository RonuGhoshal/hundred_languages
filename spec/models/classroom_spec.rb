require "rails_helper"

RSpec.describe Classroom, type: :model do
  let(:school) { create(:school) }
  let(:classroom) { create(:classroom, school: school) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(classroom).to be_valid
    end

    it "requires a school" do
      classroom.school = nil
      expect(classroom).not_to be_valid
    end

    it "requires a name" do
      classroom.name = nil
      expect(classroom).not_to be_valid
    end

    it "requires a school_year" do
      classroom.school_year = nil
      expect(classroom).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to a school" do
      expect(classroom).to belong_to(:school)
    end

    it "has and belongs to many students" do
      expect(classroom).to have_and_belong_to_many(:students)
    end

    it "has many classrooms_teachers" do
      expect(classroom).to have_many(:classrooms_teachers)
    end
  end

  describe "#update_teachers" do
    let(:teacher1) { create(:teacher, school: school) }
    let(:teacher2) { create(:teacher, school: school) }

    before do
      classroom.teachers << [ teacher1, teacher2 ]
    end

    it "adds new teachers" do
      expect(classroom.teacher_ids).to include(teacher1.id, teacher2.id)
    end

    it "removes unassigned teachers" do
      classroom.teachers.delete(teacher2)
      expect(classroom.teacher_ids).to include(teacher1.id)
      expect(classroom.teacher_ids).not_to include(teacher2.id)
    end
  end
end
