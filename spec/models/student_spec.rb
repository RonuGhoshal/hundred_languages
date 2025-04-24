require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) { create(:student) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(student).to be_valid
    end

    it "requires a first name" do
      student.first_name = nil
      expect(student).not_to be_valid
    end

    it "requires a last name" do
      student.last_name = nil
      expect(student).not_to be_valid
    end

    it "requires a school" do
      student.school = nil
      expect(student).not_to be_valid
    end

    it "requires an active classroom" do
      student.active_classroom = nil
      expect(student).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to a school" do
      expect(student).to belong_to(:school)
    end

    it "belongs to an active classroom" do
      expect(student).to belong_to(:active_classroom).class_name('Classroom')
    end

    it "has and belongs to many classrooms" do
      expect(student).to have_and_belong_to_many(:classrooms)
    end

    it "has and belongs to many notes" do
      expect(student).to have_and_belong_to_many(:notes)
    end
  end
end
