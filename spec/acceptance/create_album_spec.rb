require 'acceptance/acceptance_helper'

feature 'Create album' do
  background do
    user_is_logged_in
  end

  scenario 'Empty albumspage' do
    visit user_albums_path(current_user)
    page.should have_link 'Add one now', href: new_user_album_path(current_user)
  end

  scenario 'Filled albumspage' do
    album = Fabricate(:album, user: current_user)
    visit user_albums_path(current_user)
    page.should have_link 'Add Album', href: new_user_album_path(current_user)
  end

  scenario 'Adding an Album shows it on the albumspage' do
    visit new_user_album_path(current_user)

    fill_in 'Title', with: 'Mutter'
    fill_in 'Artist', with: 'Rammstein'
    fill_in 'Year', with: '2001'
    click_button 'Add Album'

    current_path.should == user_albums_path(current_user)
    page.should have_content 'Mutter'
  end

end
