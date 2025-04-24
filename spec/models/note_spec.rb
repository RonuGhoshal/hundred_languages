require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:teacher) { create(:teacher) }
  let(:note) { create(:note, author: teacher) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(note).to be_valid
    end

    it "requires content" do
      note.content = nil
      expect(note).not_to be_valid
    end

    it "requires an author" do
      note.author = nil
      expect(note).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to an author (teacher)" do
      expect(note).to belong_to(:author).class_name('Teacher')
    end

    it "has and belongs to many students" do
      expect(note).to have_and_belong_to_many(:students)
    end

    it "has many comments" do
      expect(note).to have_many(:comments)
    end
  end
end 