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

ActiveRecord::Schema.define(version: 2019_11_19_043115) do

  create_table "evaluations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "post_id"
    t.integer "score"
    t.index ["post_id"], name: "index_evaluations_on_post_id"
  end

  create_table "followings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "from_id", null: false
    t.bigint "to_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_id"], name: "index_followings_on_from_id"
    t.index ["to_id"], name: "index_followings_on_to_id"
  end

  create_table "post_evaluations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "post_id"
    t.bigint "user_id"
    t.float "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_evaluations_on_post_id"
    t.index ["user_id"], name: "index_post_evaluations_on_user_id"
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "source_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "current_sign_in_ip"
    t.datetime "last_sign_in_ip"
    t.string "name", null: false
    t.string "bio"
    t.string "phone", null: false
    t.string "email", null: false
    t.string "icon"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "evaluations", "posts"
  add_foreign_key "followings", "users", column: "from_id"
  add_foreign_key "followings", "users", column: "to_id"
  add_foreign_key "post_evaluations", "posts"
  add_foreign_key "post_evaluations", "users"
  add_foreign_key "posts", "users"
end
