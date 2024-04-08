# frozen_string_literal: true

# rails_admin
RailsAdmin.config do |config|
  config.asset_source = :sprockets

  config.authenticate_with do
    authenticate_or_request_with_http_basic('Login required') do |email, password|
      user = User.find_by(is_admin: true, email:)
      break unless user.present?

      User.authenticate(email, password)
    end
  end

  config.actions do
    dashboard
    index
    new
    show
    edit
    delete
  end
end
