# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Do not raise error when a before_action's only/except options reference missing actions
    config.action_controller.raise_on_missing_callback_actions = false

    # Allow controllers to use cookies
    config.middleware.use ActionDispatch::Cookies

    # Automatically convert JSON between snake_case and camelCase
    config.middleware.use OliveBranch::Middleware, inflection: 'camel'

    # good_job config
    config.active_job.queue_adapter = :good_job
    ## Normally this would not be :external for :development, but our docker-compose
    ## has a good_job runner
    config.good_job.execution_mode = :external
    ## Middleware required for good_job
    config.middleware.use Rack::MethodOverride
    config.middleware.use ActionDispatch::Flash
    config.middleware.use ActionDispatch::Session::CookieStore
    ## Scheduled jobs
    config.good_job.enable_cron = true
    config.good_job.cron = {}
  end
end
