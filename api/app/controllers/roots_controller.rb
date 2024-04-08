# frozen_string_literal: true

class RootsController < ApplicationController
  skip_before_action :authenticate, only: :index

  def index
    redirect_to ENV['FRONTEND_URL'], allow_other_host: true
  end
end
