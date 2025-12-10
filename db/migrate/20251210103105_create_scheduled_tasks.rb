class CreateScheduledTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :scheduled_tasks do |t|
      t.string :title, null: false
      t.text :description
      t.datetime :due_at, null: false
      t.string :recurrence
      t.integer :notify_minutes_before, default: 30
      t.datetime :completed_at

      t.timestamps
    end

    add_index :scheduled_tasks, :due_at
    add_index :scheduled_tasks, :completed_at
  end
end
