require "test_helper"

class TeacherTest < ActiveSupport::TestCase
  def setup
    @school = schools(:one)
    @teacher = @school.teachers.build(
      first_name: "Test",
      last_name: "Teacher",
      email_address: "test#{Time.now.to_i}@example.com",
      password: "password"
    )
  end

  test "should be valid" do
    assert @teacher.valid?
  end

  test "should require a school" do
    @teacher.school = nil
    assert_not @teacher.valid?
  end

  test "should require a first name" do
    @teacher.first_name = nil
    assert_not @teacher.valid?
  end

  test "should require a last name" do
    @teacher.last_name = nil
    assert_not @teacher.valid?
  end

  test "should require an email address" do
    @teacher.email_address = nil
    assert_not @teacher.valid?
  end

  test "should require a unique email address" do
    duplicate_teacher = @teacher.dup
    @teacher.save!
    assert_not duplicate_teacher.valid?
  end

  test "should require a password" do
    @teacher.password = nil
    assert_not @teacher.valid?
  end

  test "should have many classrooms through classrooms_teachers" do
    assert_respond_to @teacher, :classrooms
    assert_respond_to @teacher, :classroom_ids
  end

  test "should have many classrooms_teachers" do
    assert_respond_to @teacher, :classrooms_teachers
  end

  test "should have many students through classrooms" do
    assert_respond_to @teacher, :students
  end

  test "should have many notes" do
    assert_respond_to @teacher, :notes
    assert_respond_to @teacher, :note_ids
  end

  test "should have many comments" do
    assert_respond_to @teacher, :comments
    assert_respond_to @teacher, :comment_ids
  end

  test "should have many sessions" do
    assert_respond_to @teacher, :sessions
    assert_respond_to @teacher, :session_ids
  end

  test "should normalize email address" do
    @teacher.email_address = " TEST@EXAMPLE.COM "
    @teacher.save
    assert_equal "test@example.com", @teacher.email_address
  end

  test "should require valid role" do
    @teacher.role = "invalid_role"
    assert_not @teacher.valid?
  end

  test "should have secure password" do
    assert_respond_to @teacher, :password_digest
    assert_respond_to @teacher, :authenticate
  end

  test "admin? should return true for admin role" do
    @teacher.role = "admin"
    assert @teacher.admin?
  end

  test "teacher? should return true for teacher role" do
    @teacher.role = "teacher"
    assert @teacher.teacher?
  end

  test "full_name should return concatenated first and last name" do
    assert_equal "Test Teacher", @teacher.full_name
  end

  test "invite should create new teacher when invited by admin" do
    admin = teachers(:admin)
    assert_difference "Teacher.count" do
      Teacher.invite(
        email_address: "new@example.com",
        school: @school,
        invited_by: admin,
        first_name: "New",
        last_name: "Teacher"
      )
    end
  end

  test "invite should not create teacher when not invited by admin" do
    non_admin = teachers(:teacher)
    assert_no_difference "Teacher.count" do
      Teacher.invite(
        email_address: "new@example.com",
        school: @school,
        invited_by: non_admin,
        first_name: "New",
        last_name: "Teacher"
      )
    end
  end
end
