# frozen_string_literal: true

class DestroyExpiredSessionsJob < ApplicationJob
  queue_as :default

  def perform
    Session.where(expires_at: ..Time.zone.now).delete_all
  end
end
