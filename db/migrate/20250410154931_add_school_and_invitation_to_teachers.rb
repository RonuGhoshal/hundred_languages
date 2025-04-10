class AddSchoolAndInvitationToTeachers < ActiveRecord::Migration[8.0]
  def change
    add_reference :teachers, :school, null: false, foreign_key: true
    add_column :teachers, :role, :string, default: 'teacher'
    add_column :teachers, :invitation_token, :string
    add_index :teachers, :invitation_token, unique: true
  end
end
