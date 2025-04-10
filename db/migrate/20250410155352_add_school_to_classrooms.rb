class AddSchoolToClassrooms < ActiveRecord::Migration[8.0]
  def change
    add_reference :classrooms, :school, null: false, foreign_key: true
  end
end
