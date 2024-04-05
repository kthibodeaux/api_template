# frozen_string_literal: true

class HealthController < ApplicationController
  def show
    head :ok
  end
end
