class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions do |t|
      t.string :internal_name, null: false
      t.string :name, null: false
      t.string :description

      t.timestamps
    end
    add_index :permissions, :internal_name, unique: true
    add_index :permissions, :name, unique: true
  end
end
