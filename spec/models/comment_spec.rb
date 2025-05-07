require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:teacher) { create(:teacher) }
  let(:note) { create(:note, author: teacher) }
  let(:comment) { create(:comment, author: teacher, note: note) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(comment).to be_valid
    end

    it "requires content" do
      comment.content = nil
      expect(comment).not_to be_valid
    end

    it "requires an author" do
      comment.author = nil
      expect(comment).not_to be_valid
    end

    it "requires a note" do
      comment.note = nil
      expect(comment).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to an author (teacher)" do
      expect(comment).to belong_to(:author).class_name('Teacher')
    end

    it "belongs to a note" do
      expect(comment).to belong_to(:note)
    end
  end
end
