require 'acceptance/acceptance_helper'

feature 'Search my albums' do
  background do
    user_is_logged_in
  end

  let(:album) { Fabricate(:album, title: 'Mutter', artist: 'Rammstein', user: current_user) }
  let(:other_album) { Fabricate(:album, title: 'Bright Lights', artist: 'Ellie Goulding', user: current_user) }
  let(:similar_album) { Fabricate(:album, title: 'Wie Mutter und Tochter', artist: 'Badesalz', user: current_user) }

  context 'when searching for the title' do
    before(:each) { search_for album.title }

    scenario 'shows the album with exact title' do
      page.should show_album album
    end

    scenario 'shows the album with similar title' do
      page.should show_album similar_album
    end

    scenario 'shows not the album with different title' do
      page.should_not show_album other_album
    end
  end

  context 'when searching for the artist' do
    before(:each) { search_for album.artist }

    scenario 'shows the album with the artist' do
      page.should show_album album
    end

    scenario 'shows not the albums with different artists' do
      page.should_not show_album other_album
      page.should_not show_album similar_album
    end
  end

  def search_for term
    visit user_albums_path(current_user)
    fill_in I18n.t(:search), with: term
    click_button I18n.t(:go)
  end
end
