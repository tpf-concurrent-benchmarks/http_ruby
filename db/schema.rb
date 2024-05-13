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

ActiveRecord::Schema[7.1].define(version: 2024_05_01_211704) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "options", id: false, force: :cascade do |t|
    t.integer "option_num"
    t.string "option_text"
    t.bigint "poll_id"
    t.index ["poll_id", "option_num"], name: "index_options_on_poll_id_and_option_num", unique: true
    t.index ["poll_id"], name: "index_options_on_poll_id"
  end

  create_table "polls", force: :cascade do |t|
    t.string "title"
    t.bigint "creator_id", null: false
    t.index ["creator_id"], name: "index_polls_on_creator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

  create_table "votes", id: false, force: :cascade do |t|
    t.integer "option_num"
    t.bigint "user_id"
    t.bigint "poll_id"
    t.index ["poll_id"], name: "index_votes_on_poll_id"
    t.index ["user_id", "poll_id"], name: "index_votes_on_user_id_and_poll_id", unique: true
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "options", "polls"
  add_foreign_key "polls", "users", column: "creator_id"
  add_foreign_key "votes", "polls"
  add_foreign_key "votes", "users"
end
