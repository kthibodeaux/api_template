# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :set_current_request_details
  before_action :authenticate

  private

  def authenticate
    session = Session.find_signed(cookies.signed[SessionsController::COOKIE_NAME])

    if session
      Current.session = session
    else
      render json: { error: 'You must be logged in' }, status: :unauthorized
    end
  end

  def set_current_request_details
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
  end
end
