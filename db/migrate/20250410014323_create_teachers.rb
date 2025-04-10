class CreateTeachers < ActiveRecord::Migration[8.0]
  def change
    create_table :teachers do |t|
      t.string :email_address, null: false
      t.string :password_digest, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false

      t.timestamps
    end
    add_index :teachers, :email_address, unique: true
  end
end
