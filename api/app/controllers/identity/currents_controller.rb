# frozen_string_literal: true

class Identity::CurrentsController < ApplicationController
  def show
    render json: Current.user
  end
end
