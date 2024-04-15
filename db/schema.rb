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

ActiveRecord::Schema[7.0].define(version: 2024_04_15_051856) do
  create_table "categories", charset: "utf8", force: :cascade do |t|
    t.string "category_name", null: false, comment: "カテゴリ名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "web_site_infos", charset: "utf8", force: :cascade do |t|
    t.text "site_title", null: false, comment: "サイトタイトル"
    t.text "summary_text", null: false, comment: "要約文"
    t.text "site_URL", null: false, comment: "サイトURL"
    t.bigint "category_id", null: false, comment: "カテゴリ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_web_site_infos_on_category_id"
  end

  add_foreign_key "web_site_infos", "categories"
end
