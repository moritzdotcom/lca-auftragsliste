# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_12_090221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flats", force: :cascade do |t|
    t.string "location"
    t.bigint "house_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_id"], name: "index_flats_on_house_id"
  end

  create_table "houses", force: :cascade do |t|
    t.string "address"
    t.string "postal_code"
    t.string "city"
    t.string "company"
    t.integer "object_number"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_houses_on_user_id"
  end

  create_table "partners", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "task_number"
    t.bigint "house_id", null: false
    t.bigint "flat_id", null: false
    t.bigint "tenant_id", null: false
    t.string "partner_array"
    t.bigint "user_id", null: false
    t.string "title"
    t.text "description"
    t.datetime "due_date"
    t.integer "status"
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flat_id"], name: "index_tasks_on_flat_id"
    t.index ["house_id"], name: "index_tasks_on_house_id"
    t.index ["tenant_id"], name: "index_tasks_on_tenant_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.bigint "flat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flat_id"], name: "index_tenants_on_flat_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "mobile_phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "flats", "houses"
  add_foreign_key "houses", "users"
  add_foreign_key "tasks", "flats"
  add_foreign_key "tasks", "houses"
  add_foreign_key "tasks", "tenants"
  add_foreign_key "tasks", "users"
  add_foreign_key "tenants", "flats"
end
