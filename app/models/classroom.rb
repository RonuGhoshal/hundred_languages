class Classroom < ApplicationRecord
  belongs_to :school
  has_and_belongs_to_many :students, counter_cache: :students_count
  has_many :classrooms_teachers, dependent: :destroy
  has_many :teachers, through: :classrooms_teachers
  accepts_nested_attributes_for :classrooms_teachers, allow_destroy: true
  accepts_nested_attributes_for :students, allow_destroy: true
end
