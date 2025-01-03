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

ActiveRecord::Schema[7.2].define(version: 2025_01_02_133055) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classrooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.bigint "subject_id", null: false
    t.bigint "classroom_id", null: false
    t.time "start_time"
    t.time "end_time"
    t.string "days", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_sections_on_classroom_id"
    t.index ["subject_id"], name: "index_sections_on_subject_id"
    t.index ["teacher_id"], name: "index_sections_on_teacher_id"
  end

  create_table "sections_students", id: false, force: :cascade do |t|
    t.bigint "section_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id", "student_id"], name: "index_sections_students_on_section_id_and_student_id", unique: true
    t.index ["section_id"], name: "index_sections_students_on_section_id"
    t.index ["student_id"], name: "index_sections_students_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "sections", "classrooms"
  add_foreign_key "sections", "subjects"
  add_foreign_key "sections", "teachers"
  add_foreign_key "sections_students", "sections"
  add_foreign_key "sections_students", "students"
end
