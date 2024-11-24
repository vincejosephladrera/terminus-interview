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

ActiveRecord::Schema[7.2].define(version: 2024_11_24_115159) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "certs", force: :cascade do |t|
    t.string "county_id"
    t.string "value"
    t.string "index_number"
    t.string "bidder_id"
    t.bigint "certs_id"
    t.bigint "property_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["certs_id"], name: "index_certs_on_certs_id"
    t.index ["property_id"], name: "index_certs_on_property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.string "display_name"
    t.string "address"
    t.string "market_value"
    t.string "owner_address"
    t.string "state_id"
    t.string "lat"
    t.string "lng"
    t.string "construction_type"
    t.string "city"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  add_foreign_key "certs", "certs", column: "certs_id"
  add_foreign_key "certs", "properties"
end
