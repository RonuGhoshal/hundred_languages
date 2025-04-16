class AddStudentsCountToClassrooms < ActiveRecord::Migration[8.0]
  def change
    add_column :classrooms, :students_count, :integer, default: 0, null: false
  end
end 