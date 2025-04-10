class School < ApplicationRecord
  has_many :teachers
  has_many :classrooms
  has_many :students

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :phone, presence: true
end
