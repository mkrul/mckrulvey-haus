class CreatePhoneNumbers < ActiveRecord::Migration[8.0]
  def change
    create_table :phone_numbers do |t|
      t.string :name, null: false
      t.string :number, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :phone_numbers, :number, unique: true
  end
end
