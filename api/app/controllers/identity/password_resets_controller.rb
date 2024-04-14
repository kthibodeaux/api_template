# frozen_string_literal: true

class Identity::PasswordResetsController < ApplicationController
  skip_before_action :authenticate

  before_action :skip_authorization
  before_action :set_user, only: :update

  def create
    user = User.find_by(email: params[:email], verified: true)

    UserMailer.with(user:).password_reset.deliver_later if user

    head :no_content
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by_token_for!(:password_reset, params[:sid])
  rescue StandardError
    render json: { errors: ['That password reset link is invalid'] }, status: :bad_request
  end

  def user_params
    params.permit(:password, :password_confirmation)
  end
end
