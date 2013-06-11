require 'acceptance/acceptance_helper'

feature 'View albums' do
  background do
    user_is_logged_in
  end

  scenario 'No albums saved' do
    visit '/'
    page.should have_content 'No albums added yet'
  end

  scenario 'Show saved albums' do
    album = Fabricate(:album, user: current_user)
    visit '/'
    page.should have_css "div#album_#{album.id}"
    page.should have_content album.long_title
    page.should_not have_content 'No albums added yet'
  end
end
