# frozen_string_literal: true

class RootsController < ApplicationController
  skip_before_action :authenticate, only: :index
  skip_after_action :verify_authorized

  def index
    redirect_to ENV['FRONTEND_URL'], allow_other_host: true
  end
end
