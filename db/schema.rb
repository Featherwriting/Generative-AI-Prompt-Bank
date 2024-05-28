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

ActiveRecord::Schema[7.0].define(version: 2024_04_03_080018) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "admin_email"
    t.boolean "active_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "purpose"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "examples", force: :cascade do |t|
    t.bigint "prompt_id"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prompt_id"], name: "index_examples_on_prompt_id"
  end

  create_table "issues", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issues_prompts", id: false, force: :cascade do |t|
    t.bigint "prompt_id", null: false
    t.bigint "issue_id", null: false
    t.index ["issue_id", "prompt_id"], name: "index_issues_prompts_on_issue_id_and_prompt_id"
    t.index ["prompt_id", "issue_id"], name: "index_issues_prompts_on_prompt_id_and_issue_id"
  end

  create_table "prompts", force: :cascade do |t|
    t.bigint "category_id"
    t.text "prompt_content"
    t.integer "stat"
    t.string "submitter_email"
    t.integer "use_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_prompts_on_category_id"
  end

  create_table "prompts_tags", id: false, force: :cascade do |t|
    t.bigint "prompt_id", null: false
    t.bigint "tag_id", null: false
    t.index ["prompt_id", "tag_id"], name: "index_prompts_tags_on_prompt_id_and_tag_id"
    t.index ["tag_id", "prompt_id"], name: "index_prompts_tags_on_tag_id_and_prompt_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cas_ticket"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "uid"
    t.string "mail"
    t.string "ou"
    t.string "dn"
    t.string "sn"
    t.string "givenname"
    t.string "account_type"
    t.boolean "active_state"
    t.boolean "is_manager"
    t.index ["email"], name: "index_users_on_email"
    t.index ["username"], name: "index_users_on_username"
  end

end
