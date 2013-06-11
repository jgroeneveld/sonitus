require 'acceptance/acceptance_helper'

feature 'Edit albums' do
  background do
    user_is_logged_in
    album = Fabricate(:album, user: current_user)
    @album_selector = "#album_#{album.id}"
  end

  scenario 'Not in Edit Mode', js: true do
    visit user_albums_path(current_user)
    page.should_not have_selector '.album .controls.visible'
  end

  scenario 'Entering Edit Mode', js: true do
    visit user_albums_path(current_user)
    click_link 'Edit Albums'
    page.should have_selector '.album .controls.visible'
    page.should have_selector '.album .controls .edit'
    page.should have_selector '.album .controls .delete'
  end

  scenario 'Deleting Album disappears on current page', js: true do
    visit user_albums_path(current_user)
    click_link 'Edit Albums'

    page.should have_selector @album_selector
    page.find("#{@album_selector} .delete").click
    page.should_not have_selector @album_selector
  end

  scenario 'Deleting Album disappears after reload', js: true do
    visit user_albums_path(current_user)
    click_link 'Edit Albums'

    page.should have_selector @album_selector
    page.find("#{@album_selector} .delete").click
    visit current_path
    page.should_not have_selector @album_selector
  end

  scenario 'Deleting last Album shows initial message again', js: true do
    visit user_albums_path(current_user)
    click_link 'Edit Albums'

    page.should have_selector @album_selector
    page.find("#{@album_selector} .delete").click
    page.should have_link 'Add one now', href: new_user_album_path(current_user)
  end
end
