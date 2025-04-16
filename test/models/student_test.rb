require "test_helper"

class StudentTest < ActiveSupport::TestCase
  def setup
    @school = schools(:one)
    @classroom = @school.classrooms.build(name: "Test Classroom")
    @classroom.save!
    @student = @school.students.build(
      first_name: "Test",
      last_name: "Student",
      dob: Date.today,
      active_classroom: @classroom
    )
  end

  test "should be valid" do
    assert @student.valid?
  end

  test "should require a school" do
    @student.school = nil
    assert_not @student.valid?
  end

  test "should require a first name" do
    @student.first_name = nil
    assert_not @student.valid?
  end

  test "should require a last name" do
    @student.last_name = nil
    assert_not @student.valid?
  end

  test "should require a date of birth" do
    @student.dob = nil
    assert_not @student.valid?
  end

  test "should require an active classroom" do
    @student.active_classroom = nil
    assert_not @student.valid?
  end

  test "should belong to many classrooms" do
    assert_respond_to @student, :classrooms
    assert_respond_to @student, :classroom_ids
  end

  test "should have many teachers through classrooms" do
    assert_respond_to @student, :teachers
    assert_respond_to @student, :teacher_ids
  end

  test "should have many notes" do
    assert_respond_to @student, :notes
    assert_respond_to @student, :note_ids
  end

  test "should belong to many notes through notes_students" do
    assert_respond_to @student, :notes_students
  end

  test "should accept nested attributes for notes" do
    assert_respond_to @student, :notes_attributes=
  end
end
