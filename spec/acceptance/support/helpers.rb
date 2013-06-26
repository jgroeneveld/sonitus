module HelperMethods
  def user_is_logged_in
    @current_user = Fabricate(:user)
    login_as @current_user, scope: :user
  end

  def current_user
    @current_user
  end

  def sft(scope, key)
    I18n.t(key, scope: [:simple_form, :labels, scope])
  end

  def album_selector(album)
    "#album_#{album.id}"
  end
end

RSpec.configuration.include HelperMethods, type: :acceptance