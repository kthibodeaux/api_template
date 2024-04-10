# frozen_string_literal: true

FactoryBot.define do
  factory :session do
    user
    expires_at { Time.zone.now + 1.day }
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
