# frozen_string_literal: true

class AddEmailChangeToToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :email_change_to, :string, null: true
  end
end
