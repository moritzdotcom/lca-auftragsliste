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

ActiveRecord::Schema.define(version: 2021_03_13_220325) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.uuid "uuid"
    t.index ["uuid"], name: "index_companies_on_uuid", unique: true
  end

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
    t.bigint "company_id", null: false
    t.integer "object_number"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "owner_id"
    t.index ["company_id"], name: "index_houses_on_company_id"
    t.index ["owner_id"], name: "index_houses_on_owner_id"
    t.index ["user_id"], name: "index_houses_on_user_id"
  end

  create_table "mail_logs", force: :cascade do |t|
    t.string "sender"
    t.string "recipient"
    t.string "subject"
    t.string "body_html"
    t.string "body_text"
    t.string "attachment_filenames"
    t.datetime "date"
    t.string "message_id"
    t.string "smtp_response"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "postal_code"
    t.string "city"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_owners_on_company_id"
  end

  create_table "partners", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "company_name"
    t.bigint "user_id"
    t.index ["company_id"], name: "index_partners_on_company_id"
    t.index ["user_id"], name: "index_partners_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "task_number"
    t.bigint "house_id", null: false
    t.bigint "flat_id"
    t.bigint "tenant_id"
    t.string "partner_array"
    t.string "partner_names"
    t.bigint "user_id", null: false
    t.string "title"
    t.text "description"
    t.datetime "due_date"
    t.integer "status"
    t.integer "priority"
    t.integer "year"
    t.boolean "mail_sent"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "released"
    t.index ["company_id"], name: "index_tasks_on_company_id"
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
    t.bigint "company_id", null: false
    t.integer "table_settings"
    t.string "navbar_bg_settings"
    t.string "navbar_color_settings"
    t.boolean "show_mobile_on_pdf"
    t.boolean "superadmin"
    t.boolean "admin"
    t.boolean "can_create_tasks"
    t.boolean "can_manage_houses"
    t.boolean "can_manage_partners"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "flats", "houses"
  add_foreign_key "houses", "companies"
  add_foreign_key "houses", "owners"
  add_foreign_key "houses", "users"
  add_foreign_key "owners", "companies"
  add_foreign_key "partners", "companies"
  add_foreign_key "partners", "users"
  add_foreign_key "tasks", "companies"
  add_foreign_key "tasks", "flats"
  add_foreign_key "tasks", "houses"
  add_foreign_key "tasks", "tenants"
  add_foreign_key "tasks", "users"
  add_foreign_key "tenants", "flats"
  add_foreign_key "users", "companies"
end
