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

ActiveRecord::Schema.define(version: 20141219133919) do

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.string   "answer_text"
    t.decimal  "mark_score",   precision: 7, scale: 2
    t.integer  "answer_group",                         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "games", force: true do |t|
    t.string   "title"
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.integer  "game_id"
    t.text     "question_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["game_id"], name: "index_questions_on_game_id"

  create_table "user_answers", force: true do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.decimal  "mark",        precision: 7, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_answers", ["question_id"], name: "index_user_answers_on_question_id"
  add_index "user_answers", ["user_id"], name: "index_user_answers_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
