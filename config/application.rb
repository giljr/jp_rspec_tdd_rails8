require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TddApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    config.i18n.default_locale = :'pt-BR'

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

    # Configure generators to use RSpec instead of Test::Unit
    # So when you run generators (rails g scaffold, rails g model, etc.),
    # only model and request specs (and maybe controller specs if you enable them) are created.    #
    # Key points:
    # system_specs: true → ensures Rails generates RSpec system tests (Capybara) when you run rails g system_test.
    # request_specs: true → enables request specs, which are the preferred way to test controllers in Rails 8.
    # controller_specs: false → since controller specs are considered legacy.
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: true,
                       controller_specs: false,
                       system_specs: true
    end
  end

end
