class CreateFreezers < ActiveRecord::Migration[8.0]
  def change
    create_table :freezers do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :freezers, :name, unique: true
  end
end
