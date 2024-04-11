# frozen_string_literal: true

class Identity::AttributesController < ApplicationController
  before_action :set_user

  def update
    if @user.update(user_params)
      render_show
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = authorize Current.user
  end

  def user_params
    params.permit(:email, :password, :password_confirmation, :password_challenge).with_defaults(password_challenge: '')
  end

  def render_show
    resend_email_verification if @user.email_previously_changed?

    render json: @user
  end

  def resend_email_verification
    UserMailer.with(user: @user).email_verification.deliver_later
  end
end
