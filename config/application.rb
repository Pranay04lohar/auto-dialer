require_relative "boot"
require "rails"
require "action_controller/railtie"
require "active_support/railtie"
require "active_job/railtie"

Bundler.require(*Rails.groups)

module Autodialer
  class Application < Rails::Application
    config.load_defaults 7.0
    config.active_job.queue_adapter = :async  # No Redis needed!
  end
end
