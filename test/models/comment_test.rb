require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @school = schools(:one)
    @teacher = @school.teachers.build(
      first_name: "Test",
      last_name: "Teacher",
      email_address: "test#{Time.now.to_i}@example.com",
      password: "password"
    )
    @teacher.save!
    @note = @teacher.notes.build(content: "Test note content")
    @note.save!
    @comment = @note.comments.build(
      content: "Test comment content",
      author: @teacher
    )
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "should require content" do
    @comment.content = nil
    assert_not @comment.valid?
  end

  test "should require an author" do
    @comment.author = nil
    assert_not @comment.valid?
  end

  test "should require a note" do
    @comment.note = nil
    assert_not @comment.valid?
  end
end
