class CreateToken < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :name, null: false
      t.integer :count, null: false
      t.decimal :rate, null: false, default: 0

      t.references :uploaded_file, foreign_key: true
    end
  end
end
