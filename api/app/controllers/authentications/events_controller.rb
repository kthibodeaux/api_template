# frozen_string_literal: true

class Authentications::EventsController < ApplicationController
  def index
    render json: Current.user.events.order(created_at: :desc)
  end
end
