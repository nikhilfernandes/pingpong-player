# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150716215022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "championships", force: true do |t|
    t.string  "identity"
    t.string  "status"
    t.integer "num_players_joined"
    t.string  "title"
  end

  create_table "games", force: true do |t|
    t.string  "game_identity"
    t.string  "oponent_identity"
    t.string  "status"
    t.integer "player_id"
    t.integer "championship_id"
    t.string  "outcome"
  end

  create_table "players", force: true do |t|
    t.string  "auth_token"
    t.integer "championship_id"
    t.string  "status"
  end

  create_table "rounds", force: true do |t|
    t.string  "game_id"
    t.string  "round_identity"
    t.string  "role"
    t.integer "order_of_play"
    t.string  "outcome"
  end

end
