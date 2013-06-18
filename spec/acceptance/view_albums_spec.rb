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
    background do
      @album = Fabricate(:album_with_image, user: current_user)
      visit user_albums_path(current_user)
    end

    scenario 'show saved albums' do
      page.should show_album @album
      page.should have_content @album.title
      page.should have_content @album.artist
      page.should have_image @album.image.for_collection.url
      page.should_not have_content I18n.t(:no_albums_added_yet)
    end

    context 'clicking on an albums image' do
      background do
        click_on_album @album
      end

      scenario 'shows details page' do
        current_path.should == user_album_path(current_user, @album)
      end

      scenario 'shows image' do
        page.should have_image @album.image.url
      end
    end
  end

  def click_on_album(album)
    link = page.find("#{album_selector(album)} img").find(:xpath, '..')
    link.click
  end
end
