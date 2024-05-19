# frozen_string_literal: true

module Identity
  class PasswordsController < ApplicationController
    def update
      user = authorize Current.user

      if user.update(user_params)
        render json: user
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.permit(:password, :password_confirmation)
    end
  end
end
