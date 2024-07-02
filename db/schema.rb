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

ActiveRecord::Schema[7.0].define(version: 2024_07_02_075349) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "drugs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "hospital_name"
    t.string "drug_name"
    t.integer "number_of_tablets"
    t.string "image_url"
    t.date "start_time"
    t.date "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_drugs_on_user_id"
  end

  create_table "line_user_ids", force: :cascade do |t|
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_line_user_ids_on_uid", unique: true
  end

  create_table "medication_checks", force: :cascade do |t|
    t.bigint "drug_id", null: false
    t.bigint "take_time_id", null: false
    t.boolean "check"
    t.date "check_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drug_id"], name: "index_medication_checks_on_drug_id"
    t.index ["take_time_id"], name: "index_medication_checks_on_take_time_id"
  end

  create_table "memos", force: :cascade do |t|
    t.bigint "drug_id", null: false
    t.text "body"
    t.date "create_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "take_times", force: :cascade do |t|
    t.bigint "drug_id", null: false
    t.integer "take_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drug_id"], name: "index_take_times_on_drug_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "drugs", "users"
  add_foreign_key "medication_checks", "drugs"
  add_foreign_key "medication_checks", "take_times"
  add_foreign_key "take_times", "drugs"
end
