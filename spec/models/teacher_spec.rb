require 'rails_helper'

RSpec.describe Teacher, type: :model do
  let(:teacher) { create(:teacher) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(teacher).to be_valid
    end

    it "requires a first name" do
      teacher.first_name = nil
      expect(teacher).not_to be_valid
    end

    it "requires a last name" do
      teacher.last_name = nil
      expect(teacher).not_to be_valid
    end

    it "requires an email address" do
      teacher.email_address = nil
      expect(teacher).not_to be_valid
    end

    it "requires a unique email address" do
      existing_teacher = create(:teacher)
      teacher.email_address = existing_teacher.email_address
      expect(teacher).not_to be_valid
    end

    it "requires a password_digest" do
      teacher.password_digest = nil
      expect(teacher).not_to be_valid
    end

    it "requires a school" do
      teacher.school = nil
      expect(teacher).not_to be_valid
    end

    it "has a default role of 'teacher'" do
      expect(teacher.role).to eq('teacher')
    end
  end

  describe "associations" do
    it "belongs to a school" do
      expect(teacher).to belong_to(:school)
    end

    it "has many classrooms through classrooms_teachers" do
      expect(teacher).to have_many(:classrooms).through(:classrooms_teachers)
    end

    it "has many classrooms_teachers" do
      expect(teacher).to have_many(:classrooms_teachers)
    end

    it "has many notes" do
      expect(teacher).to have_many(:notes)
    end

    it "has many comments" do
      expect(teacher).to have_many(:comments)
    end

    it "has many sessions" do
      expect(teacher).to have_many(:sessions)
    end
  end
end
