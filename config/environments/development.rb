QuentManager::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
c#onfig.action_mailer.default_url_options = { :host => 'http://siquitutes.herokuapp.com' }


  #These settings are for the sending out email for active admin and consequently the   devise mailer
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = 
  {

    :address            => 'smtp.gmail.com',
    :port               => 587,
    :domain             => 'gmail.com', #you can also use google.com
    :authentication     => :plain,
    :user_name          => 'rafaelbpcrespo@gmail.com',
    :password           => '17rafa12R'
    :enable_starttls_auto => true
}

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
end
