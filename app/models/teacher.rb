class Teacher < ApplicationRecord
  has_secure_password
  belongs_to :school
  has_many :sessions, dependent: :destroy
  has_and_belongs_to_many :classrooms
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

  def self.invite(email:, school:, invited_by:)
    return unless invited_by.admin?

    teacher = Teacher.new(
      email_address: email,
      school: school,
      role: "teacher",
      password: SecureRandom.hex(10) # temporary password
    )

    if teacher.save
      # You would typically send an email here with the invitation token
      # TeacherMailer.invitation_email(teacher).deliver_later
      teacher
    end
  end
end
