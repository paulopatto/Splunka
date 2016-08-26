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

ActiveRecord::Schema.define(version: 20160826050946) do

  create_table "sales", force: :cascade do |t|
    t.string   "customer"
    t.string   "description"
    t.decimal  "unit_price",     precision: 12, scale: 2
    t.integer  "amount"
    t.string   "address"
    t.string   "supplier"
    t.integer  "sales_batch_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "sales", ["sales_batch_id"], name: "index_sales_on_sales_batch_id"

  create_table "sales_batches", force: :cascade do |t|
    t.string   "attachment"
    t.boolean  "processed",                           default: false
    t.decimal  "revenue",    precision: 12, scale: 2, default: 0.0
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "batch_code"
  end

  add_index "sales_batches", ["batch_code"], name: "index_sales_batches_on_batch_code"

end
