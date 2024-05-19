# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'Secret1*3*5*' }
    verified { true }

    trait :admin do
      is_admin { true }
    end

    trait :not_verified do
      verified { false }
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  deactivated_at  :datetime
#  email           :string           not null
#  email_change_to :string
#  is_admin        :boolean          default(FALSE), not null
#  password_digest :string           not null
#  verified        :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
