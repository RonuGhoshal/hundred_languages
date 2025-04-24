class Classroom < ApplicationRecord
  belongs_to :school
  has_and_belongs_to_many :students
  has_many :classrooms_teachers, dependent: :destroy
  has_many :teachers, through: :classrooms_teachers
  accepts_nested_attributes_for :students, allow_destroy: true

  validates :name, presence: true
  validates :school_year, presence: true

  def update_teachers(teacher_ids)
    current_teacher_ids = teachers.pluck(:id)
    new_teacher_ids = teacher_ids.map(&:to_i)

    # Remove teachers that are no longer assigned
    (current_teacher_ids - new_teacher_ids).each do |teacher_id|
      classrooms_teachers.find_by(teacher_id: teacher_id)&.destroy
    end

    # Add new teachers
    (new_teacher_ids - current_teacher_ids).each do |teacher_id|
      classrooms_teachers.create(teacher_id: teacher_id)
    end
  end
end
