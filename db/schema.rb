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

ActiveRecord::Schema.define(version: 20150128150013) do

  create_table "pfm1s", force: :cascade do |t|
    t.integer  "id_in_plu",  limit: 4
    t.integer  "width",      limit: 4, default: 0
    t.integer  "height",     limit: 4, default: 0
    t.integer  "l1",         limit: 4, default: 0
    t.integer  "l2",         limit: 4, default: 0
    t.integer  "l3",         limit: 4, default: 0
    t.integer  "k1",         limit: 4, default: 0
    t.integer  "k2",         limit: 4, default: 0
    t.integer  "k3",         limit: 4, default: 0
    t.integer  "is_check",   limit: 4, default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

end