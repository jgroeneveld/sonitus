require 'acceptance/acceptance_helper'

feature 'Create album' do
  background do
    user_is_logged_in
  end

  scenario 'Empty albumspage shows link to create an album in the middle' do
    visit user_albums_path(current_user)
    page.should have_link I18n.t(:add_one_now), href: new_user_album_path(current_user)
  end

  scenario 'Filled albumspage has simpler link to create an album' do
    album = Fabricate(:album, user: current_user)
    visit user_albums_path(current_user)
    page.should have_link I18n.t(:new_album), href: new_user_album_path(current_user)
  end

  scenario 'Adding an Album shows it on the albumspage' do
    visit new_user_album_path(current_user)

    fill_in sft(:album, :title), with: 'Mutter'
    fill_in sft(:album, :artist), with: 'Rammstein'
    fill_in sft(:album, :year), with: '2001'
    click_button I18n.t(:new_album)

    current_path.should == user_albums_path(current_user)
    page.should have_content 'Mutter'
  end

end
