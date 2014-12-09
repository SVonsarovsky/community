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

ActiveRecord::Schema.define(version: 20141126212159) do

  create_table "blogs", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pictures", ["imageable_id", "imageable_type"], name: "index_pictures_on_imageable_id_and_imageable_type"

  create_table "plans", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price",       precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_infos", force: true do |t|
    t.integer  "post_id"
    t.integer  "views"
    t.integer  "likes"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "blog_id"
  end

  add_index "posts", ["blog_id"], name: "index_posts_on_blog_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "posts_tags", id: false, force: true do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  add_index "posts_tags", ["post_id", "tag_id"], name: "index_posts_tags_on_post_id_and_tag_id"
  add_index "posts_tags", ["post_id"], name: "index_posts_tags_on_post_id"
  add_index "posts_tags", ["tag_id"], name: "index_posts_tags_on_tag_id"

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "blog_id"
    t.boolean  "receive_news"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["blog_id"], name: "index_subscriptions_on_blog_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_plans", force: true do |t|
    t.integer  "user_id"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_plans", ["plan_id"], name: "index_user_plans_on_plan_id"
  add_index "user_plans", ["user_id"], name: "index_user_plans_on_user_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "last_name"
    t.boolean  "receive_news", default: true
    t.boolean  "admin"
  end

  add_index "users", ["receive_news"], name: "index_users_on_receive_news"

end
