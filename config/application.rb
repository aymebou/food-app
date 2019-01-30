require_relative 'boot'

require 'rails/all'
require 'net/http'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DemoApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
    config.assets.precompile += ['vendor/assets/**/*']
    config.assets.precompile += %w('app/assets/javascripts/dashboardCtrl.js.erb')
    config.assets.precompile += %w(*.svg *.woff *.woff2 *.ttf *.otf *.eot *.png *.jpg *.jpeg *.gif)
    config.assets.initialize_on_precompile = false

    config.angular_templates.module_name    = 'templates'
    config.angular_templates.inside_paths   = ['app/assets']
    config.angular_templates.markups        = %w(erb)
    config.angular_templates.extension      = 'html'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :put , :options, :delete]
      end
    end



  end
end
