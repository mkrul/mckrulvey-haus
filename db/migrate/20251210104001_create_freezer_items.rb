class CreateFreezerItems < ActiveRecord::Migration[8.0]
  def change
    create_table :freezer_items do |t|
      t.references :freezer, null: false, foreign_key: true
      t.string :name, null: false
      t.string :category, null: false
      t.integer :weight_lbs
      t.integer :weight_oz
      t.date :packaged_date
      t.date :expiration_date

      t.timestamps
    end

    add_index :freezer_items, :name
    add_index :freezer_items, :category
    add_index :freezer_items, :expiration_date
  end
end
