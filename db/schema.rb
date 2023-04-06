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

ActiveRecord::Schema[7.0].define(version: 2023_04_02_093545) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "data_expert_id", null: false
    t.bigint "status"
    t.bigint "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["data_expert_id"], name: "index_orders_on_data_expert_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "data_expert_id", null: false
    t.bigint "status"
    t.bigint "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["data_expert_id"], name: "index_orders_on_data_expert_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "frequency"
    t.date "day"
    t.time "time"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "db_connections", force: :cascade do |t|
    t.integer "user_id"
    t.string "display_name"
    t.integer "connection_type"
    t.integer "db_port"
    t.string "db_name"
    t.string "db_user"
    t.string "db_pass"
    t.integer "analytics_account_id"
    t.string "json_file"
    t.string "csv_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_dashboards", force: :cascade do |t|
    t.integer "user_id"
    t.integer "dashboard_id"
    t.integer "permission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.bigint "phone_number"
    t.string "occupation"
  end

  add_foreign_key "cards", "dashboards", on_delete: :cascade
  add_foreign_key "cards", "db_connections", on_delete: :cascade
  add_foreign_key "cards", "users", column: "owner_id", on_delete: :cascade
  add_foreign_key "orders", "users", column: "customer_id", on_delete: :cascade
  add_foreign_key "orders", "users", column: "data_expert_id", on_delete: :cascade
end
