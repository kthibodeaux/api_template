# frozen_string_literal: true

class AdminApplicationController < ApplicationController
  before_action :verify_admin

  private

  def verify_admin
    raise Pundit::NotAuthorizedError unless current_user.admin?
  end
end
