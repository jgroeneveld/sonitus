require 'acceptance/acceptance_helper'

feature 'Edit album collection' do
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
    click_link I18n.t(:edit_albums)

    page.should show_album_edit_controls
    page.should show_album_edit_button
    page.should show_album_delete_button
  end


  context 'Editing an Album' do
    scenario 'Clicking Edit Button', js: true do
      visit user_albums_path(current_user)
      click_link I18n.t(:edit_albums)

      click_edit_button_for @album
      current_path.should == edit_user_album_path(current_user, @album)
    end

    scenario 'Changing an Albums title' do
      visit edit_user_album_path(current_user, @album)
      fill_in 'Title', with: 'Was Anderes'
      click_button I18n.t(:edit_album)
      @album.reload
      @album.title.should == 'Was Anderes'
    end
  end

  context 'Deleting Albums' do
    before(:each) { enter_edit_mode_and_delete_album }

    scenario 'Asks for confirmation before deleting', js: true do
      should_have_shown_confirm I18n.t(:confirm_album_delete)
    end

    scenario 'Deleted Album disappears on current page', js: true do
      page.should_not show_album @album
    end

    scenario 'Deleted Album stays gone after reload', js: true do
      visit current_path
      page.should_not show_album @album
    end

    scenario 'Deleting last Album shows initial message again', js: true do
      page.should have_link I18n.t(:add_one_now), href: new_user_album_path(current_user)
    end
  end


  private

  def enter_edit_mode_and_delete_album
    visit user_albums_path(current_user)
    click_link I18n.t(:edit_albums)

    page.should show_album @album
    click_delete_button_for @album
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

  def click_edit_button_for(album)
    page.find("#album_#{album.id} .edit").click
  end

  def should_have_shown_confirm(msg)
    page.driver.confirm_messages.should_not be_nil
    page.driver.confirm_messages.should include msg
  end
end
