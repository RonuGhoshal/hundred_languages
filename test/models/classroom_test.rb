require "test_helper"

class ClassroomTest < ActiveSupport::TestCase
  def setup
    @school = schools(:one)
    @classroom = @school.classrooms.build(name: "Test Classroom")
  end

  test "should be valid" do
    assert @classroom.valid?
  end

  test "should require a school" do
    @classroom.school = nil
    assert_not @classroom.valid?
  end

  test "should have many students" do
    assert_respond_to @classroom, :students
    assert_respond_to @classroom, :student_ids
  end

  test "should have many teachers through classrooms_teachers" do
    assert_respond_to @classroom, :teachers
    assert_respond_to @classroom, :teacher_ids
  end

  test "should have many classrooms_teachers" do
    assert_respond_to @classroom, :classrooms_teachers
  end

  test "update_teachers should add new teachers" do
    timestamp = Time.now.to_i
    teacher1 = @school.teachers.build(
      first_name: "One",
      last_name: "Teacher",
      email_address: "one#{timestamp}@example.com",
      password: "password"
    )
    teacher2 = @school.teachers.build(
      first_name: "Two",
      last_name: "Teacher",
      email_address: "two#{timestamp}@example.com",
      password: "password"
    )
    teacher1.save!
    teacher2.save!

    @classroom.save
    @classroom.teachers << [teacher1, teacher2]

    assert_includes @classroom.teacher_ids, teacher1.id
    assert_includes @classroom.teacher_ids, teacher2.id
  end

  test "update_teachers should remove unassigned teachers" do
    timestamp = Time.now.to_i
    teacher1 = @school.teachers.build(
      first_name: "One",
      last_name: "Teacher",
      email_address: "one#{timestamp}@example.com",
      password: "password"
    )
    teacher2 = @school.teachers.build(
      first_name: "Two",
      last_name: "Teacher",
      email_address: "two#{timestamp}@example.com",
      password: "password"
    )
    teacher1.save!
    teacher2.save!

    @classroom.save
    @classroom.teachers << [teacher1, teacher2]
    @classroom.teachers.delete(teacher2)

    assert_includes @classroom.teacher_ids, teacher1.id
    assert_not_includes @classroom.teacher_ids, teacher2.id
  end

  test "should accept nested attributes for students" do
    assert_respond_to @classroom, :students_attributes=
  end
end
