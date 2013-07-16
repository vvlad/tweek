require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Tweek
  class Application < Rails::Application

    config.active_record.whitelist_attributes = false
    config.action_controller.action_on_unpermitted_parameters = :raise

  end
end
