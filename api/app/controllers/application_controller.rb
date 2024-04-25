# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Cookies
  include Pundit::Authorization

  before_action :set_current_request_details
  before_action :authenticate

  after_action :verify_authorized, except: :index

  rescue_from Pundit::NotAuthorizedError do |_e|
    head :unauthorized
  end

  private

  def authenticate
    session = Session.find_signed(cookies.signed[SessionsController::COOKIE_NAME])

    if session
      if session.expired? || !session.user.active?
        session.destroy
        cookies.delete SessionsController::COOKIE_NAME

        render json: { error: 'You must be logged in' }, status: :unauthorized
      else
        Current.session = session
      end
    else
      render json: { error: 'You must be logged in' }, status: :unauthorized
    end
  end

  def current_user
    Current.user
  end

  def set_current_request_details
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
  end
end
