# frozen_string_literal: true

class Session < ApplicationRecord
  belongs_to :user

  validates_presence_of :expires_at

  before_create do
    self.user_agent = Current.user_agent
    self.ip_address = Current.ip_address
  end

  after_create  { user.events.create! action: 'signed_in' }
  after_destroy { user.events.create! action: 'signed_out' }

  def expired?
    expires_at < Time.zone.now
  end
end

# == Schema Information
#
# Table name: sessions
#
#  id         :uuid             not null, primary key
#  expires_at :datetime         not null
#  ip_address :string
#  user_agent :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_sessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
