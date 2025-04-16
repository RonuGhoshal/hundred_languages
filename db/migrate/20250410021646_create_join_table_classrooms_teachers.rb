class CreateJoinTableClassroomsTeachers < ActiveRecord::Migration[8.0]
  def change
    create_join_table :classrooms, :teachers do |t|
      t.index [ :classroom_id, :teacher_id ], unique: true
    end
  end
end
