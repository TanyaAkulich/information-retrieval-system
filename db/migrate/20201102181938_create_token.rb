class CreateToken < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :name, null: false
      t.decimal :weight, null: false, default: 0
      t.decimal :term_inverse_frequency, null: false, default: 0

      t.references :uploaded_file, foreign_key: true
    end
  end
end
