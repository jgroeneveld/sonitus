require 'acceptance/acceptance_helper'

feature 'View albums' do
  background do
    user_is_logged_in
  end

  context 'when no albums are saved' do
    scenario 'shows no albums message' do
      visit user_albums_path(current_user)
      page.should have_content I18n.t(:no_albums_added_yet)
    end
  end

  context 'when some albums are saved' do
    scenario 'show saved albums' do
      album = Fabricate(:album, user: current_user)
      visit user_albums_path(current_user)
      page.should have_css "div#album_#{album.id}"
      page.should have_content album.long_title
      page.should_not have_content I18n.t(:no_albums_added_yet)
    end
  end
end
