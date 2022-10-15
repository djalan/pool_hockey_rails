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

ActiveRecord::Schema.define(version: 20220926212330) do

  create_table "players", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "points"
    t.integer  "goals"
    t.integer  "assists"
    t.integer  "rank"
    t.integer  "nhl_points"
    t.integer  "nhl_goals"
    t.integer  "nhl_assists"
    t.integer  "nhl_rank"
    t.string   "team",             limit: 255
    t.string   "last_team",        limit: 255
    t.string   "power_play",       limit: 255
    t.string   "pp_last_year",     limit: 255
    t.string   "position",         limit: 255
    t.integer  "salary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color",            limit: 255
    t.integer  "games"
    t.string   "drafted",          limit: 255, default: "no"
    t.string   "season",           limit: 255, default: "unknown"
    t.integer  "my_rank_global",               default: 9999
    t.integer  "my_rank_position",             default: 9999
    t.string   "even_strength"
    t.string   "draft_year"
    t.string   "contract"
    t.string   "info"
    t.integer  "live_draft"
  end

end
