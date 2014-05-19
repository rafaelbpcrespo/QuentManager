# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
QuentManager::Application.initialize!

Time::DATE_FORMATS[:default] = "%d/%m/%Y"
