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

ActiveRecord::Schema[7.0].define(version: 2024_04_15_140941) do
  create_table "categories", charset: "utf8", force: :cascade do |t|
    t.string "category_name", null: false, comment: "カテゴリ名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sinfo_scategories", charset: "utf8", force: :cascade do |t|
    t.bigint "web_site_info_id", null: false, comment: "サイト情報"
    t.bigint "sub_category_id", null: false, comment: "サブカテゴリ"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sub_category_id"], name: "index_sinfo_scategories_on_sub_category_id"
    t.index ["web_site_info_id"], name: "index_sinfo_scategories_on_web_site_info_id"
  end

  create_table "sub_categories", charset: "utf8", force: :cascade do |t|
    t.text "scategory_name", null: false, comment: "サブカテゴリ名"
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

  add_foreign_key "sinfo_scategories", "sub_categories"
  add_foreign_key "sinfo_scategories", "web_site_infos"
  add_foreign_key "web_site_infos", "categories"
end
