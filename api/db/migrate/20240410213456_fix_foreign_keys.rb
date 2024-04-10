# frozen_string_literal: true

class FixForeignKeys < ActiveRecord::Migration[7.1]
  def change
    safety_assured do
      remove_foreign_key :events, name: 'fk_rails_0cb5590091'
      remove_foreign_key :sessions, name: 'fk_rails_758836b4f0'

      add_foreign_key :events, :users, column: :user_id, type: :uuid
      add_foreign_key :sessions, :users, column: :user_id, type: :uuid
    end
  end
end
