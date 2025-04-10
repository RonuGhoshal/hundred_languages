class CreateJoinTableNotesStudents < ActiveRecord::Migration[8.0]
  def change
    create_join_table :notes, :students do |t|
      # t.index [:note_id, :student_id]
      # t.index [:student_id, :note_id]
    end
  end
end
