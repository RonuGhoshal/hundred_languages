class CreateNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :notes do |t|
      t.text :content
      t.references :author, null: false, foreign_key: { to_table: :teachers }

      t.timestamps
    end
  end
end
