require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Forecast
  class Application < Rails::Application
    ForecastIO.configure do |configuration|
      configuration.api_key = '9c548f6c454deee62c84152e99ee4922'
    end
  end
end
