# frozen_string_literal: true

class User < ApplicationRecord
  include Deactivatable

  has_secure_password

  generates_token_for :change_email, expires_in: 2.days do
    email_change_to
  end

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end

  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  has_many :sessions, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 12 }

  normalizes :email, with: -> { _1.strip.downcase }

  after_update if: :email_previously_changed? do
    events.create! action: 'email_changed'
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
    events.create! action: 'password_changed'
  end

  def admin?
    !!is_admin
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
