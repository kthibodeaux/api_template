# frozen_string_literal: true

class Identity::CurrentsController < ApplicationController
  skip_after_action :verify_authorized

  def show
    render json: {
      session: Current.session.as_json(only: SessionsController::SESSION_FIELDS),
      user: Current.user.as_json(only: SessionsController::USER_FIELDS)
    }
  end
end
