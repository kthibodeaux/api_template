# frozen_string_literal: true

module Identity
  class EmailsController < ApplicationController
    skip_before_action :authenticate, only: :update

    before_action :skip_authorization, only: :update

    def create
      user = authorize Current.user, :update?

      if user.update(user_params)
        UserMailer.with(user:).change_email.deliver_later
        head :no_content
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      user = User.find_by_token_for(:change_email, params[:sid])

      if user
        if user.update(email: user.email_change_to, email_change_to: nil)
          render json: user
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: ['That email verification link is invalid'] }, status: :bad_request
      end
    end

    private

    def user_params
      params.permit(:email_change_to)
    end
  end
end
