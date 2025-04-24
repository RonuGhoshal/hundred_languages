require 'rails_helper'

RSpec.describe School, type: :model do
  let(:school) { create(:school) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(school).to be_valid
    end

    it "requires a name" do
      school.name = nil
      expect(school).not_to be_valid
    end
  end

  describe "associations" do
    it "has many classrooms" do
      expect(school).to have_many(:classrooms)
    end

    it "has many teachers" do
      expect(school).to have_many(:teachers)
    end

    it "has many students" do
      expect(school).to have_many(:students)
    end
  end
end 