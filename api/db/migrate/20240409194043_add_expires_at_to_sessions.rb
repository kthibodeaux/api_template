# frozen_string_literal: true

class AddExpiresAtToSessions < ActiveRecord::Migration[7.1]
  def change
    add_column :sessions, :expires_at, :timestamp, null: false
  end
end
