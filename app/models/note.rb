class Note < ApplicationRecord
  belongs_to :author, class_name: "Teacher"
  has_many :comments
  has_and_belongs_to_many :students
end
