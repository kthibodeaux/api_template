# frozen_string_literal: true

class Identity::CurrentsController < ApplicationController
  def show
    render json: {
      session: { id: Current.session.id },
      user: Current.user
    }
  end
end
