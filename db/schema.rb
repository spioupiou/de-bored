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

ActiveRecord::Schema.define(version: 2022_02_12_092720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "name"
  end

  create_table "games_contents", force: :cascade do |t|
    t.text "content"
    t.bigint "game_id", null: false
    t.index ["game_id"], name: "index_games_contents_on_game_id"
  end

  create_table "instances", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.string "status"
    t.integer "pin"
    t.index ["game_id"], name: "index_instances_on_game_id"
    t.index ["user_id"], name: "index_instances_on_user_id"
  end

  create_table "player_inputs", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "instance_id", null: false
    t.string "type"
    t.text "value"
    t.index ["instance_id"], name: "index_player_inputs_on_instance_id"
    t.index ["player_id"], name: "index_player_inputs_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "instance_id", null: false
    t.index ["instance_id"], name: "index_players_on_instance_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "nickname"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "games_contents", "games"
  add_foreign_key "instances", "games"
  add_foreign_key "instances", "users"
  add_foreign_key "player_inputs", "instances"
  add_foreign_key "player_inputs", "players"
  add_foreign_key "players", "instances"
  add_foreign_key "players", "users"
end
