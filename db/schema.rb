# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_10_204938) do

  create_table "activities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "date"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "cities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "department_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_cities_on_department_id"
  end

  create_table "countries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "country_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_departments_on_country_id"
  end

  create_table "dues", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "periodicity"
    t.decimal "interests", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventory_transfers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "recipient_id"
    t.date "date"
    t.bigint "ware_id"
    t.integer "quantity"
    t.text "observations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_inventory_transfers_on_recipient_id"
    t.index ["sender_id"], name: "index_inventory_transfers_on_sender_id"
    t.index ["ware_id"], name: "index_inventory_transfers_on_ware_id"
  end

  create_table "load_wares", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "ware_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "observations"
    t.index ["user_id"], name: "index_load_wares_on_user_id"
    t.index ["ware_id"], name: "index_load_wares_on_ware_id"
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.bigint "department_id"
    t.bigint "city_id"
    t.date "date"
    t.string "client_name"
    t.string "client_phone"
    t.string "spouse_name"
    t.string "spouse_phone"
    t.string "address_one"
    t.string "neighborhood_address_one"
    t.string "address_two"
    t.string "neighborhood_address_two"
    t.string "familiar_reference"
    t.string "familiar_reference_phone"
    t.string "personal_reference"
    t.string "personal_reference_phone"
    t.date "payment_date"
    t.text "observations"
    t.integer "quota_quantity", default: 0
    t.decimal "quota_amount", precision: 13, scale: 2, default: "0.0"
    t.decimal "total_paid", precision: 13, scale: 2, default: "0.0"
    t.decimal "latitude", precision: 10, scale: 6, default: "0.0"
    t.decimal "longitude", precision: 10, scale: 6, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "status", default: 0
    t.bigint "due_id"
    t.index ["city_id"], name: "index_orders_on_city_id"
    t.index ["department_id"], name: "index_orders_on_department_id"
    t.index ["due_id"], name: "index_orders_on_due_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "orders_wares", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "ware_id"
    t.integer "quantity", default: 0
    t.decimal "total", precision: 13, scale: 2, default: "0.0"
    t.text "observations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_orders_wares_on_order_id"
    t.index ["ware_id"], name: "index_orders_wares_on_ware_id"
  end

  create_table "payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "order_id"
    t.decimal "total_paid", precision: 13, scale: 2
    t.date "date"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.text "observations"
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstname"
    t.string "lastname"
    t.string "cellphone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "wares", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "reference"
    t.string "name"
    t.decimal "price", precision: 13, scale: 2
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "activities", "users"
  add_foreign_key "cities", "departments"
  add_foreign_key "departments", "countries"
  add_foreign_key "inventory_transfers", "users", column: "recipient_id"
  add_foreign_key "inventory_transfers", "users", column: "sender_id"
  add_foreign_key "inventory_transfers", "wares"
  add_foreign_key "load_wares", "users"
  add_foreign_key "load_wares", "wares"
  add_foreign_key "orders", "cities"
  add_foreign_key "orders", "departments"
  add_foreign_key "orders_wares", "orders"
  add_foreign_key "orders_wares", "wares"
  add_foreign_key "payments", "orders"
end
