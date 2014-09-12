# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
QuentManager::Application.initialize!

Time::DATE_FORMATS[:default] = "%d/%m/%Y"

# ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| "#{html_tag}" }