class ClassroomsTeacher < ApplicationRecord
  belongs_to :classroom
  belongs_to :teacher

  validates :classroom_id, uniqueness: { scope: :teacher_id }
end