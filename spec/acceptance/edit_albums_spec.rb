require 'acceptance/acceptance_helper'

feature 'Edit albums' do
  background do
    user_is_logged_in
    @album = Fabricate(:album, user: current_user)
  end

  scenario 'Not in Edit Mode', js: true do
    visit user_albums_path(current_user)
    page.should_not show_album_edit_controls
  end

  scenario 'Entering Edit Mode', js: true do
    visit user_albums_path(current_user)
    click_link 'Edit Albums'

    page.should show_album_edit_controls
    page.should show_album_edit_button
    page.should show_album_delete_button
  end

  scenario 'Deleting Album disappears on current page', js: true do
    visit user_albums_path(current_user)
    click_link 'Edit Albums'

    page.should show_album @album
    click_delete_button_for @album
    page.should_not show_album @album
  end

  scenario 'Deleting Album disappears after reload', js: true do
    visit user_albums_path(current_user)
    click_link 'Edit Albums'

    page.should show_album @album
    click_delete_button_for @album
    visit current_path
    page.should_not show_album @album
  end

  scenario 'Deleting last Album shows initial message again', js: true do
    visit user_albums_path(current_user)
    click_link 'Edit Albums'

    page.should show_album @album
    click_delete_button_for @album
    page.should have_link 'Add one now', href: new_user_album_path(current_user)
  end

  def show_album_edit_controls
    have_selector '.album .controls.visible'
  end

  def show_album_edit_button
    have_selector '.album .controls .edit'
  end

  def show_album_delete_button
    have_selector '.album .controls .delete'
  end

  def show_album(album)
    have_selector "#album_#{album.id}"
  end

  def click_delete_button_for(album)
    page.find("#album_#{album.id} .delete").click
  end
end
