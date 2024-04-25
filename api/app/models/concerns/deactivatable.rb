# frozen_string_literal: true

module Deactivatable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(deactivated_at: nil) }
  end

  def active?
    deactivated_at.nil?
  end

  def activate
    self.deactivated_at = nil
  end

  def activate!
    update(deactivated_at: nil)
  end

  def deactivate
    self.deactivated_at = Time.zone.now
  end

  def deactivate!
    update(deactivated_at: Time.zone.now)
  end
end
