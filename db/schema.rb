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

ActiveRecord::Schema.define(version: 20180415114259) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ja_group", null: false
    t.string "ja", null: false
    t.string "en_group", null: false
    t.string "en", null: false
    t.string "zh_group", null: false
    t.string "zh", null: false
    t.string "tw_group", null: false
    t.string "tw", null: false
  end

  create_table "client_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "client_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_client_categories_on_category_id"
    t.index ["client_id"], name: "index_client_categories_on_client_id"
  end

  create_table "client_contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "client_id"
    t.string "tel"
    t.string "address"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_client_contacts_on_client_id"
  end

  create_table "client_locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "client_id"
    t.bigint "country_id"
    t.bigint "prefecture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_client_locations_on_client_id"
    t.index ["country_id"], name: "index_client_locations_on_country_id"
    t.index ["prefecture_id"], name: "index_client_locations_on_prefecture_id"
  end

  create_table "client_option_prices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "client_id"
    t.string "name", null: false
    t.boolean "along_with_time", default: false, null: false
    t.integer "price"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_client_option_prices_on_client_id"
  end

  create_table "client_portfolios", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "client_id"
    t.string "image"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_client_portfolios_on_client_id"
  end

  create_table "client_primary_prices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "client_id"
    t.integer "price_per_hour", null: false
    t.integer "minimum_hours", default: 1, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_client_primary_prices_on_client_id"
  end

  create_table "client_schedules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "client_id"
    t.date "date", null: false
    t.text "schedule"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_client_schedules_on_client_id"
  end

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.text "introduction"
    t.text "camera"
    t.string "image"
    t.boolean "consent", default: false, null: false
    t.datetime "deleted_at"
    t.boolean "confirmed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ja", null: false
    t.string "en", null: false
    t.string "zh", null: false
    t.string "tw", null: false
  end

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.text "introduction"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "event_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "event_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_event_categories_on_category_id"
    t.index ["event_id"], name: "index_event_categories_on_event_id"
  end

  create_table "event_option_prices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "event_id"
    t.bigint "client_option_price_id"
    t.integer "numbers", default: 1, null: false
    t.integer "price_sum", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_option_price_id"], name: "index_event_option_prices_on_client_option_price_id"
    t.index ["event_id"], name: "index_event_option_prices_on_event_id"
  end

  create_table "event_photos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "event_id"
    t.string "image"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_photos_on_event_id"
  end

  create_table "event_primary_prices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "event_id"
    t.bigint "client_primary_price_id"
    t.integer "hours", null: false
    t.integer "price_sum", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_primary_price_id"], name: "index_event_primary_prices_on_client_primary_price_id"
    t.index ["event_id"], name: "index_event_primary_prices_on_event_id"
  end

  create_table "event_reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "event_id"
    t.text "cl_review"
    t.text "cl_comment"
    t.text "cs_review"
    t.integer "stars"
    t.string "cs_image_1"
    t.string "cs_image_2"
    t.string "cs_image_3"
    t.string "cs_image_4"
    t.string "cs_image_5"
    t.string "cs_image_6"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_reviews_on_event_id"
  end

  create_table "event_states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "event_id"
    t.string "state", null: false
    t.text "comment"
    t.boolean "cl_read", default: false, null: false
    t.boolean "cs_read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_states_on_event_id"
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "client_id"
    t.bigint "customer_id"
    t.bigint "prefecture_id"
    t.text "location_detail", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.integer "total_price", null: false
    t.integer "num_people", null: false
    t.text "message", null: false
    t.integer "primary_price_sum"
    t.integer "option_price_sum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_events_on_client_id"
    t.index ["customer_id"], name: "index_events_on_customer_id"
    t.index ["prefecture_id"], name: "index_events_on_prefecture_id"
  end

  create_table "languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "ja", null: false
    t.string "ja_s", null: false
    t.string "en", null: false
    t.string "en_s", null: false
    t.string "zh", null: false
    t.string "zh_s", null: false
    t.string "tw", null: false
    t.string "tw_s", null: false
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "sender_id", null: false
    t.integer "reciever_id", null: false
    t.text "message"
    t.boolean "sender_read", default: false, null: false
    t.boolean "reciever_read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reciever_id"], name: "index_messages_on_reciever_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "prefectures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "area", null: false
    t.string "ja", null: false
    t.string "en", null: false
    t.string "zh", null: false
    t.string "tw", null: false
  end

  create_table "user_languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_user_languages_on_language_id"
    t.index ["user_id"], name: "index_user_languages_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.datetime "deleted_at"
    t.string "image"
    t.string "uid"
    t.string "provider"
    t.boolean "mail_refused", default: false, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "client_categories", "categories"
  add_foreign_key "client_categories", "clients"
  add_foreign_key "client_contacts", "clients"
  add_foreign_key "client_locations", "clients"
  add_foreign_key "client_locations", "countries"
  add_foreign_key "client_locations", "prefectures"
  add_foreign_key "client_option_prices", "clients"
  add_foreign_key "client_portfolios", "clients"
  add_foreign_key "client_primary_prices", "clients"
  add_foreign_key "client_schedules", "clients"
  add_foreign_key "clients", "users"
  add_foreign_key "customers", "users"
  add_foreign_key "event_categories", "categories"
  add_foreign_key "event_categories", "events"
  add_foreign_key "event_option_prices", "client_option_prices"
  add_foreign_key "event_option_prices", "events"
  add_foreign_key "event_photos", "events"
  add_foreign_key "event_primary_prices", "client_primary_prices"
  add_foreign_key "event_primary_prices", "events"
  add_foreign_key "event_reviews", "events"
  add_foreign_key "event_states", "events"
  add_foreign_key "events", "clients"
  add_foreign_key "events", "customers"
  add_foreign_key "events", "prefectures"
  add_foreign_key "user_languages", "languages"
  add_foreign_key "user_languages", "users"
end
