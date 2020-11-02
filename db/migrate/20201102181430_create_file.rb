class CreateFile < ActiveRecord::Migration[5.2]
  def change
    create_table :files do |t|
      t.string :name, null: false, unique: true
    end
  end
end
