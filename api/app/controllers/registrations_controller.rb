# frozen_string_literal: true

class RegistrationsController < ApplicationController
  skip_before_action :authenticate, only: :create
  skip_after_action :verify_authorized, only: :create

  def create
    @user = User.new(user_params)

    if @user.save
      send_email_verification
      head :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def send_email_verification
    UserMailer.with(user: @user).email_verification.deliver_later
  end
end
