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

ActiveRecord::Schema[7.0].define(version: 2020_02_18_125146) do
  create_table "performance_history", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "dt_stamp", precision: nil
    t.string "authority"
    t.integer "action"
    t.integer "size_bytes"
    t.float "retrieve_time_ms"
    t.float "graph_load_time_ms"
    t.float "retrieve_plus_graph_load_time_ms"
    t.float "normalization_time_ms"
    t.float "action_time_ms"
    t.index ["action"], name: "index_performance_history_on_action"
  end

  create_table "scenario_run_history", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "scenario_run_registry_id"
    t.integer "status", default: 2
    t.string "authority_name"
    t.string "subauthority_name"
    t.string "service"
    t.string "action"
    t.string "url"
    t.string "err_message"
    t.integer "scenario_type", default: 0
    t.decimal "run_time", precision: 10, scale: 4
    t.date "date"
    t.index ["authority_name"], name: "index_scenario_run_history_on_authority_name"
    t.index ["date"], name: "index_scenario_run_history_on_date"
    t.index ["scenario_run_registry_id"], name: "index_scenario_run_history_on_scenario_run_registry_id"
    t.index ["scenario_type"], name: "index_scenario_run_history_on_scenario_type"
    t.index ["status"], name: "index_scenario_run_history_on_status"
    t.index ["url"], name: "index_scenario_run_history_on_url"
  end

  create_table "scenario_run_registry", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "dt_stamp", precision: nil
  end

end
