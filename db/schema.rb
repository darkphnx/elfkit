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

ActiveRecord::Schema.define(version: 20171115170925) do

  create_table "delayed_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "priority",                 default: 0, null: false
    t.integer  "attempts",                 default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "exchanges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string   "title"
    t.string   "permalink"
    t.datetime "match_at"
    t.datetime "exchange_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "stage"
    t.datetime "match_reminder_sent_at"
    t.datetime "exchange_reminder_sent_at"
    t.string   "time_zone"
  end

  create_table "participant_matches", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "exchange_id"
    t.integer  "gifter_id"
    t.integer  "giftee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["exchange_id"], name: "index_participant_matches_on_exchange_id", using: :btree
    t.index ["giftee_id"], name: "index_participant_matches_on_giftee_id", using: :btree
    t.index ["gifter_id"], name: "index_participant_matches_on_gifter_id", using: :btree
  end

  create_table "participants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "exchange_id"
    t.string   "name"
    t.string   "email_address"
    t.string   "permalink"
    t.string   "login_token"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.boolean  "admin"
    t.boolean  "participating"
    t.datetime "last_activity_at"
    t.index ["exchange_id"], name: "index_participants_on_exchange_id", using: :btree
  end

  create_table "prohibited_matches", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer  "gifter_id"
    t.integer  "giftee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["giftee_id"], name: "index_prohibited_matches_on_giftee_id", using: :btree
    t.index ["gifter_id"], name: "index_prohibited_matches_on_gifter_id", using: :btree
  end

  add_foreign_key "prohibited_matches", "participants", column: "giftee_id"
  add_foreign_key "prohibited_matches", "participants", column: "gifter_id"
end
