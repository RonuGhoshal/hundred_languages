class Student < ApplicationRecord
  belongs_to :school
  belongs_to :active_classroom, class_name: "Classroom", optional: true
  has_and_belongs_to_many :classrooms
  has_many :teachers, through: :classrooms
  has_and_belongs_to_many :notes
  has_many :notes_students

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :dob, presence: true
  validates :school, presence: true
  validates :active_classroom, presence: true

  accepts_nested_attributes_for :notes
end
