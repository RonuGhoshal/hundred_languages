class Teacher < ApplicationRecord
  has_secure_password
  belongs_to :school
  has_many :sessions, dependent: :destroy
  has_many :classrooms_teachers, dependent: :destroy
  accepts_nested_attributes_for :classrooms_teachers, allow_destroy: true
  has_many :classrooms, through: :classrooms_teachers
  has_many :students, through: :classrooms
  accepts_nested_attributes_for :school

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # Defines the roles available for a teacher
  ROLES = %w[teacher admin].freeze
  # Validates the role of a teacher to ensure it is one of the defined roles
  validates :role, inclusion: { in: ROLES }

  # Generates a unique invitation token for each teacher, used for teacher signup
  has_secure_token :invitation_token

  # Scope to find all admin teachers
  scope :admins, -> { where(role: "admin") }
  # Scope to find all non-ad teachers
  scope :teachers, -> { where(role: "teacher") }

  def admin?
    role == "admin"
  end

  def teacher?
    role == "teacher"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.invite(email_address:, school:, invited_by:, first_name:, last_name:)
    return unless invited_by.admin?

    teacher = Teacher.new(
      email_address: email_address,
      first_name: first_name,
      last_name: last_name,
      school: school,
      role: "teacher",
      password: SecureRandom.hex(10) # temporary password
    )

    if teacher.save
      # You would typically send an email here with the invitation token
      # TeacherMailer.invitation_email(teacher).deliver_later
      InviteTeacherMailer.invite_teacher(teacher, invited_by).deliver_later
    end
  end
end
