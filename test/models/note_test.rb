require "test_helper"

class NoteTest < ActiveSupport::TestCase
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
  end

  test "should be valid" do
    assert @note.valid?
  end

  test "should require content" do
    @note.content = nil
    assert_not @note.valid?
  end

  test "should require an author" do
    @note.author = nil
    assert_not @note.valid?
  end

  test "should have many students" do
    assert_respond_to @note, :students
    assert_respond_to @note, :student_ids
  end

  test "should have many notes_students" do
    assert_respond_to @note, :notes_students
  end

  test "should have many comments" do
    assert_respond_to @note, :comments
    assert_respond_to @note, :comment_ids
  end

  test "should accept nested attributes for comments" do
    assert_respond_to @note, :comments_attributes=
  end
end
