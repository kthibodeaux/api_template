# frozen_string_literal: true

class ApplicationController < ActionController::API
  after_action :set_version_header

  private

  def set_version_header
    response.headers['api-server-version'] = ApiVersion.version
  end
end
