class Comment < ApplicationRecord
  belongs_to :author, class_name: "Teacher"
  belongs_to :note

  validates :content, presence: true
  validates :author, presence: true
  validates :note, presence: true
end
