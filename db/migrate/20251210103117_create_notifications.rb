class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.references :scheduled_task, null: false, foreign_key: true
      t.references :phone_number, null: false, foreign_key: true
      t.datetime :sent_at
      t.string :status, default: "pending", null: false

      t.timestamps
    end

    add_index :notifications, [:scheduled_task_id, :phone_number_id], unique: true
  end
end
