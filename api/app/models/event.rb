# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user

  before_create do
    self.user_agent = Current.user_agent
    self.ip_address = Current.ip_address
  end
end

# == Schema Information
#
# Table name: events
#
#  id         :uuid             not null, primary key
#  action     :string           not null
#  user_agent :string
#  ip_address :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
