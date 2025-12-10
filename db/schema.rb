# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_12_10_103117) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "notifications", force: :cascade do |t|
    t.bigint "scheduled_task_id", null: false
    t.bigint "phone_number_id", null: false
    t.datetime "sent_at"
    t.string "status", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_number_id"], name: "index_notifications_on_phone_number_id"
    t.index ["scheduled_task_id", "phone_number_id"], name: "index_notifications_on_scheduled_task_id_and_phone_number_id", unique: true
    t.index ["scheduled_task_id"], name: "index_notifications_on_scheduled_task_id"
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.string "name", null: false
    t.string "number", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_phone_numbers_on_number", unique: true
  end

  create_table "scheduled_tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.datetime "due_at", null: false
    t.string "recurrence"
    t.integer "notify_minutes_before", default: 30
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["completed_at"], name: "index_scheduled_tasks_on_completed_at"
    t.index ["due_at"], name: "index_scheduled_tasks_on_due_at"
  end

  add_foreign_key "notifications", "phone_numbers"
  add_foreign_key "notifications", "scheduled_tasks"
end
