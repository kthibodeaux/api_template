# frozen_string_literal: true

class ConvertToUuid < ActiveRecord::Migration[7.1]
  def change
    safety_assured do
      remove_foreign_key :events, name: 'fk_rails_0cb5590091'
      remove_foreign_key :sessions, name: 'fk_rails_758836b4f0'

      # Convert users table
      add_column :users, :uuid, :uuid, default: 'gen_random_uuid()', null: false
      User.reset_column_information
      change_table :users do |t|
        t.remove :id
        t.rename :uuid, :id
      end
      execute 'ALTER TABLE users ADD PRIMARY KEY (id);'
      User.reset_column_information

      # Convert events table
      add_column :events, :uuid, :uuid, default: 'gen_random_uuid()', null: false
      add_column :events, :user_uuid, :uuid, null: false
      Event.reset_column_information
      change_table :events do |t|
        t.remove :id
        t.rename :uuid, :id
        t.remove :user_id
        t.rename :user_uuid, :user_id
      end
      execute 'ALTER TABLE events ADD PRIMARY KEY (id);'
      Event.reset_column_information
      add_foreign_key :events, :users, column: :user_id, type: :uuid, on_delete: :cascade
      add_index :events, :user_id

      # Convert sessions table
      add_column :sessions, :uuid, :uuid, default: 'gen_random_uuid()', null: false
      add_column :sessions, :user_uuid, :uuid, null: false
      Session.reset_column_information
      change_table :sessions do |t|
        t.remove :id
        t.rename :uuid, :id
        t.remove :user_id
        t.rename :user_uuid, :user_id
      end
      execute 'ALTER TABLE sessions ADD PRIMARY KEY (id);'
      Session.reset_column_information
      add_foreign_key :sessions, :users, column: :user_id, type: :uuid, on_delete: :cascade
      add_index :sessions, :user_id
    end
  end
end
