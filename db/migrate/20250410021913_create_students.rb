class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.references :active_classroom, null: false, foreign_key: { to_table: :classrooms }

      t.timestamps
    end
  end
end
