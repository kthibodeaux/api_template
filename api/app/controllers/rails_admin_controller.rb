# frozen_string_literal: true

class RailsAdminController < ActionController::Base
  before_action :authenticate

  private

  def authenticate
    session = Session.find_signed(cookies.signed[SessionsController::COOKIE_NAME])

    return unless session

    if session.expired? || !session.user.admin?
      session.destroy
      cookies.delete SessionsController::COOKIE_NAME
    else
      Current.session = session
    end
  end

  def current_user
    Current.user
  end
end
