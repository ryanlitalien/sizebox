# Load the rails application
require File.expand_path('../application', __FILE__)

AppConstants.config_path = "#{File.dirname(__FILE__)}/constants.yml"
AppConstants.environment = Rails.env.to_s
AppConstants.load!

# Initialize the rails application
Sizebox::Application.initialize!
