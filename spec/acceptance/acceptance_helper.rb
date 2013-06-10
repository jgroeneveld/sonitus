require 'spec_helper'

# Put your acceptance spec helpers inside spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

include Warden::Test::Helpers
Warden.test_mode!

module AcceptanceHelpers
  def user_is_logged_in
    @current_user = Fabricate(:user)
    login_as @current_user, scope: :user
  end

  def current_user
    @current_user
  end
end


RSpec.configure do |c|
  c.include AcceptanceHelpers
end