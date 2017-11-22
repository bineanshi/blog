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

ActiveRecord::Schema.define(version: 20171122164102) do

  create_table "article_categories", force: :cascade do |t|
    t.string   "name",       limit: 255, comment: "品目名称"
    t.string   "desc",       limit: 255, comment: "描述"
    t.integer  "position",   limit: 4,   comment: "位置"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "article_categories", ["id"], name: "index_article_categories_on_id", using: :btree
  add_index "article_categories", ["name"], name: "index_article_categories_on_name", using: :btree
  add_index "article_categories", ["position"], name: "index_article_categories_on_position", using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title",                limit: 255,   comment: "标题"
    t.string   "tabloid",              limit: 255,   comment: "摘要"
    t.string   "author_name",          limit: 255,   comment: "作者"
    t.text     "content",              limit: 65535, comment: "文章内容"
    t.datetime "submited_at",                        comment: "发布时间"
    t.boolean  "is_publish",                         comment: "是否发布"
    t.string   "desc",                 limit: 255,   comment: "备注"
    t.integer  "article_category_id",  limit: 4,     comment: "分类ID"
    t.string   "source_category_name", limit: 255,   comment: "分类名称"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "article_url",          limit: 255
  end

  add_index "articles", ["article_category_id"], name: "index_articles_on_article_category_id", using: :btree
  add_index "articles", ["author_name"], name: "index_articles_on_author_name", using: :btree
  add_index "articles", ["id"], name: "index_articles_on_id", using: :btree
  add_index "articles", ["is_publish"], name: "index_articles_on_is_publish", using: :btree
  add_index "articles", ["source_category_name"], name: "index_articles_on_source_category_name", using: :btree
  add_index "articles", ["title"], name: "index_articles_on_title", using: :btree

  create_table "site_rules", force: :cascade do |t|
    t.integer  "site_id",    limit: 4
    t.string   "site_name",  limit: 255
    t.string   "rule_name",  limit: 255
    t.text     "rule_value", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "images",     limit: 65535
    t.text     "links",      limit: 65535
  end

  add_index "site_rules", ["rule_name"], name: "index_site_rules_on_rule_name", using: :btree
  add_index "site_rules", ["site_id"], name: "index_site_rules_on_site_id", using: :btree
  add_index "site_rules", ["site_name"], name: "index_site_rules_on_site_name", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "site_name",  limit: 255
    t.string   "search_url", limit: 255
    t.string   "main_url",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sites", ["main_url"], name: "index_sites_on_main_url", using: :btree
  add_index "sites", ["search_url"], name: "index_sites_on_search_url", using: :btree
  add_index "sites", ["site_name"], name: "index_sites_on_site_name", using: :btree

end
