# frozen_string_literal: true

class Identity::CurrentsController < ApplicationController
  def show
    render json: {
      session: Current.session.as_json(only: SessionsController::SESSION_FIELDS),
      user: Current.user.as_json(only: SessionsController::USER_FIELDS)
    }
  end
end
