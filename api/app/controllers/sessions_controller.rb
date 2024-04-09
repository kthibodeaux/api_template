# frozen_string_literal: true

class SessionsController < ApplicationController
  COOKIE_NAME = :session_id

  skip_before_action :authenticate, only: :create

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
      session = user.sessions.create!(expires_at: expire_time)

      cookies.signed[COOKIE_NAME] = {
        value: session.signed_id,
        expires: expire_time,
        httponly: true,
        secure: Rails.env.production?
      }

      render json: { session: { id: session.id }, user: }, status: :created
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def destroy
    @session.destroy
    cookies.delete COOKIE_NAME
  end

  private

  def set_session
    @session = Current.user.sessions.find(params[:id])
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
