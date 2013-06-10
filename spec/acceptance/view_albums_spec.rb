require 'acceptance/acceptance_helper'

feature 'View albums' do
  background do
    user_is_logged_in
  end

  scenario 'No albums saved' do
    visit '/'
    expect(page).to have_content 'No albums added yet'
  end

  scenario 'Show saved albums' do
    album = Fabricate(:album, user: current_user)
    visit '/'
    expect(page).to have_css "div#album_#{album.id}"
    expect(page).to_not have_content 'No albums added yet'
  end
end
