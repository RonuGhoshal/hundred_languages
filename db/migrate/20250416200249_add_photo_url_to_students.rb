class AddPhotoUrlToStudents < ActiveRecord::Migration[8.0]
  def change
    add_column :students, :photo_url, :string
  end
end
