# frozen_string_literal: true

class SessionsController < ApplicationController
  COOKIE_NAME = :session_id
  SESSION_FIELDS = %i[id]
  USER_FIELDS = %i[email is_admin]

  skip_before_action :authenticate, only: :create
  skip_after_action :verify_authorized, only: :create

  before_action :set_session, only: %i[show destroy]

  def index
    render json: Current.user.sessions.order(created_at: :desc)
  end

  def show
    render json: @session
  end

  def create
    user = User.authenticate_by(email: session_params[:email], password: session_params[:password])

    if user
      session = authorize Session.new(user:, expires_at: expire_time)
      session.save!

      cookies.signed[COOKIE_NAME] = {
        value: session.signed_id,
        expires: expire_time,
        httponly: true,
        secure: Rails.env.production?
      }

      render json: {
        session: session.as_json(only: SESSION_FIELDS),
        user: user.as_json(only: USER_FIELDS)
      }, status: :created
    else
      render json: { errors: ['Invalid credentials'] }, status: :unauthorized
    end
  end

  def destroy
    @session.destroy
    cookies.delete COOKIE_NAME
  end

  private

  def set_session
    @session = authorize Current.user.sessions.find(params[:id])
  end

  def expire_time
    length_of_time = if session_params.fetch(:remember_me)
                       1.year
                     else
                       1.day
                     end

    Time.zone.now + length_of_time
  end

  def session_params
    params.require(:session).permit(:email, :password, :remember_me)
  end
end
