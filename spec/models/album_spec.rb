require 'spec_helper'

describe Album do
  it '#long_title' do
    album = Album.new title: "Mutter", artist: "Rammstein", year: 2001
    expect(album.long_title).to eq 'Rammstein - Mutter (2001)'
  end
end
