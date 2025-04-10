class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :author, null: false, foreign_key: { to_table: :teachers }
      t.references :note, null: false, foreign_key: true

      t.timestamps
    end
  end
end
