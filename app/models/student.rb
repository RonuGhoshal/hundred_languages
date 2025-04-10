class Student < ApplicationRecord
  belongs_to :active_classroom
  has_and_belongs_to_many :classrooms
  has_many :teachers, through: :classrooms
end
