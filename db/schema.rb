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

ActiveRecord::Schema[8.0].define(version: 2025_04_10_155353) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.string "school_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "school_id", null: false
    t.integer "students_count", default: 0, null: false
    t.index ["school_id"], name: "index_classrooms_on_school_id"
  end

  create_table "classrooms_students", id: false, force: :cascade do |t|
    t.bigint "classroom_id", null: false
    t.bigint "student_id", null: false
  end

  create_table "classrooms_teachers", id: false, force: :cascade do |t|
    t.bigint "classroom_id", null: false
    t.bigint "teacher_id", null: false
    t.index ["classroom_id", "teacher_id"], name: "index_classrooms_teachers_on_classroom_id_and_teacher_id", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "author_id", null: false
    t.bigint "note_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["note_id"], name: "index_comments_on_note_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "content"
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_notes_on_author_id"
  end

  create_table "notes_students", id: false, force: :cascade do |t|
    t.bigint "note_id", null: false
    t.bigint "student_id", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_sessions_on_teacher_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.bigint "active_classroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "school_id", null: false
    t.index ["active_classroom_id"], name: "index_students_on_active_classroom_id"
    t.index ["school_id"], name: "index_students_on_school_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "school_id", null: false
    t.string "role", default: "teacher"
    t.string "invitation_token"
    t.index ["email_address"], name: "index_teachers_on_email_address", unique: true
    t.index ["invitation_token"], name: "index_teachers_on_invitation_token", unique: true
    t.index ["school_id"], name: "index_teachers_on_school_id"
  end

  add_foreign_key "classrooms", "schools"
  add_foreign_key "comments", "notes"
  add_foreign_key "comments", "teachers", column: "author_id"
  add_foreign_key "notes", "teachers", column: "author_id"
  add_foreign_key "sessions", "teachers"
  add_foreign_key "students", "classrooms", column: "active_classroom_id"
  add_foreign_key "students", "schools"
  add_foreign_key "teachers", "schools"
end
