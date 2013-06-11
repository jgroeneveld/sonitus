require 'spec_helper'

# Put your acceptance spec helpers inside spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

include Warden::Test::Helpers
Warden.test_mode!
RSpec.configure do |config|
  config.after(:each) { Warden.test_reset! }
end

Capybara.javascript_driver = :webkit