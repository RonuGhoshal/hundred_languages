class Note < ApplicationRecord
  belongs_to :author, class_name: "Teacher"
  has_many :comments
  has_and_belongs_to_many :students
  has_many :notes_students

  validates :content, presence: true
  validates :author, presence: true

  accepts_nested_attributes_for :comments
end
