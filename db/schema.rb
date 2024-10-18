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

ActiveRecord::Schema.define(version: 2024_10_11_021605) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "project_mission_task_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_mission_task_id"], name: "index_comments_on_project_mission_task_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "missions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notices", force: :cascade do |t|
    t.bigint "comment_id", null: false
    t.bigint "user_id", null: false
    t.integer "status", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["comment_id"], name: "index_notices_on_comment_id"
    t.index ["user_id"], name: "index_notices_on_user_id"
  end

  create_table "project_mission_tasks", force: :cascade do |t|
    t.bigint "project_mission_id", null: false
    t.bigint "task_id", null: false
    t.integer "status", default: 1, null: false
    t.integer "role", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.index ["project_mission_id"], name: "index_project_mission_tasks_on_project_mission_id"
    t.index ["task_id"], name: "index_project_mission_tasks_on_task_id"
  end

  create_table "project_missions", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "mission_id", null: false
    t.integer "status", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.index ["mission_id"], name: "index_project_missions_on_mission_id"
    t.index ["project_id"], name: "index_project_missions_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false, null: false
    t.integer "position", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "project_mission_tasks"
  add_foreign_key "comments", "users"
  add_foreign_key "notices", "comments"
  add_foreign_key "notices", "users"
  add_foreign_key "project_mission_tasks", "project_missions"
  add_foreign_key "project_mission_tasks", "tasks"
  add_foreign_key "project_missions", "missions"
  add_foreign_key "project_missions", "projects"
  add_foreign_key "projects", "users"
end
