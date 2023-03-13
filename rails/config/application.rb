require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hearty
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    ###
    ### generated code
    ###
    # Don't generate system test files.
    config.generators.system_tests = nil

    config.time_zone = 'Tokyo'
    # config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    # config.require_master_key = true
    config.generators do |g|
      g.template_engine :erb
      g.stylesheets false
      g.javascripts false
      g.helper false
    end
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
    config.autoload_paths << "#{Rails.root}/lib/autoloads"

    config.active_job.queue_adapter = :sidekiq
    config.active_job.queue_name_prefix = "hearty"

    initializer(:remove_action_mailbox_and_activestorage_routes, after: :add_routing_paths) { |app|
      app.routes_reloader.paths.delete_if {|path| path =~ /activestorage/}
      app.routes_reloader.paths.delete_if {|path| path =~ /actionmailbox/ }
    }

    if ENV['RAILS_HOST'].present?
      config.hosts << ENV['RAILS_HOST']
    end
    ###
    ### END generated code
    ###

    config.hosts << "akki.jp.ngrok.io"

  end
end
