# frozen_string_literal: true

ActiveSupport.on_load(:good_job_application_controller) do
  # context here is GoodJob::ApplicationController

  before_action do
    raise ActionController::RoutingError.new('Not Found') unless admin?
  end

  def admin?
    session = Session.find_signed(cookies.signed[SessionsController::COOKIE_NAME])

    return unless session && session.user.present?

    session.user.admin?
  end
end
