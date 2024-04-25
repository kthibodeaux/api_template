# frozen_string_literal: true

class Identity::EmailVerificationsController < ApplicationController
  skip_before_action :authenticate
  skip_after_action :verify_authorized

  def create
    user = User.find(params[:uid])

    if !user.verified
      UserMailer.with(user:).email_verification.deliver_later
      head :created
    else
      head :bad_request
    end
  end

  def update
    user = User.find_by_token_for(:email_verification, params[:sid])

    if user
      user.update!(verified: true)
      head :no_content
    else
      render json: { errors: ['That email verification link is invalid'] }, status: :bad_request
    end
  end
end
