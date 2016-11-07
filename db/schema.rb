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

ActiveRecord::Schema.define(version: 20161104213604) do

  create_table "exchanges", force: :cascade do |t|
    t.string   "title"
    t.string   "permalink"
    t.datetime "match_at"
    t.datetime "exchange_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "participant_matches", force: :cascade do |t|
    t.integer  "exchange_id"
    t.integer  "gifter_id"
    t.integer  "giftee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["exchange_id"], name: "index_participant_matches_on_exchange_id"
    t.index ["giftee_id"], name: "index_participant_matches_on_giftee_id"
    t.index ["gifter_id"], name: "index_participant_matches_on_gifter_id"
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "exchange_id"
    t.string   "name"
    t.string   "email_address"
    t.string   "permalink"
    t.string   "login_token"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.         "admin"
    t.index ["exchange_id"], name: "index_participants_on_exchange_id"
  end

end