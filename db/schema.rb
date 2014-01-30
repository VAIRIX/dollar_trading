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

ActiveRecord::Schema.define(version: 20140130204520) do

  create_table "companies", force: true do |t|
    t.string   "name"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "search"
    t.string   "slug"
  end

  add_index "companies", ["slug"], name: "index_companies_on_slug", unique: true

  create_table "currencies", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exchange_rates", force: true do |t|
    t.integer  "currency_id"
    t.integer  "company_id"
    t.float    "purchase"
    t.float    "sale"
    t.float    "average"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exchange_rates", ["company_id"], name: "index_exchange_rates_on_company_id"
  add_index "exchange_rates", ["currency_id"], name: "index_exchange_rates_on_currency_id"

end
