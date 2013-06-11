module HelperMethods
  def user_is_logged_in
    @current_user = Fabricate(:user)
    login_as @current_user, scope: :user
  end

  def current_user
    @current_user
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance