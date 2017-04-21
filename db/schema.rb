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

ActiveRecord::Schema.define(version: 20170421180104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rental_items", force: :cascade do |t|
    t.integer  "rental_id"
    t.integer  "tool_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rentals", force: :cascade do |t|
    t.integer  "renter_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["renter_id"], name: "index_rentals_on_renter_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.integer  "rental_item_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "comment"
  end

  create_table "tools", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.string   "owner_id"
    t.string   "picture"
    t.text     "description"
    t.float    "lat"
    t.float    "lng"
    t.integer  "deposit_cents"
    t.integer  "daily_rate_cents"
    t.boolean  "availability"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "city"
    t.string   "province"
    t.index ["owner_id"], name: "index_tools_on_owner_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
