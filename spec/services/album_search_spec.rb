require 'spec_helper'

describe AlbumSearch do
  let(:user) { Fabricate(:user) }
  let(:album_search) { AlbumSearch.new(user) }
  let(:album) { Fabricate(:album, title: 'Mutter', artist: 'Rammstein', user: current_user) }
  let(:other_album) { Fabricate(:album, title: 'Bright Lights', artist: 'Ellie Goulding', user: current_user) }
  let(:similar_album) { Fabricate(:album, title: 'Wie Mutter und Tochter', artist: 'Badesalz', user: current_user) }

  context 'when searching for the title' do
    let(:search_results) { album_search.search album.title }

    it 'finds the album with exact title' do
      search_results.should include album
    end

    it 'finds the album with similar title' do
      search_results.should include similar_album
    end

    it 'does not find the album with different title' do
      search_results.should_not include other_album
    end
  end

  context 'when searching for the artist' do
    let(:search_results) { album_search.search album.artist }

    it 'finds the album with the artist' do
      search_results.should include album
    end

    it 'does not find the albums with different artists' do
      search_results.should_not include other_album
      search_results.should_not include similar_album
    end
  end
end
