require_relative "boot"
require "rails/all"
require 'cloudinary'
require 'carrierwave'
# require 'carrierwave/storage/cloudinary'

Bundler.require(*Rails.groups)
require 'dotenv/load' if ENV['RAILS_ENV'] == 'development' || ENV['RAILS_ENV'] == 'test' || ENV['RAILS_ENV'] == 'production'

module Dafbin
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: :any
      end
    end

    config.load_defaults 7.0

    config.database_password = ENV["DAFBIN_DATABASE_PASSWORD"]

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

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Flash
    config.middleware.use Rack::MethodOverride
    config.middleware.use ActionDispatch::Session::CookieStore, {:key=>"_dafbin_session"}

  end
end
