class Student < ApplicationRecord
  belongs_to :active_classroom, class_name: "Classroom", optional: true
  has_and_belongs_to_many :classrooms
  has_many :teachers, through: :classrooms
  has_many :contacts
  has_and_belongs_to_many :notes
  accepts_nested_attributes_for :contacts, allow_destroy: true
end
