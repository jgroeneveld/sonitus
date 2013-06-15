require 'spec_helper'

describe AlbumSearch do
  before(:each) do
    @user = Fabricate(:user)
    @album = Fabricate(:album, title: 'Mutter', artist: 'Rammstein', user: @user)
    @other_album = Fabricate(:album, title: 'Bright Lights', artist: 'Ellie Goulding', user: @user)
    @similar_album = Fabricate(:album, title: 'Wie Mutter und Tochter', artist: 'Badesalz', user: @user)
  end

  let(:album_search) { AlbumSearch.new(@user) }

  context 'when searching for the title' do
    let(:search_results) { album_search.search @album.title }

    it 'finds the album with exact title' do
      search_results.should include @album
    end

    it 'finds the album with similar title' do
      search_results.should include @similar_album
    end

    it 'does not find the album with different title' do
      search_results.should_not include @other_album
    end
  end

  context 'when searching for the artist' do
    let(:search_results) { album_search.search @album.artist }

    it 'finds the album with the artist' do
      search_results.should include @album
    end

    it 'does not find the albums with different artists' do
      search_results.should_not include @other_album
      search_results.should_not include @similar_album
    end
  end
end
