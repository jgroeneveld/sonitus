require 'spec_helper'

describe Album do
  it '#long_title' do
    album = Album.new title: "Mutter", artist: "Rammstein", year: 2001
    album.long_title.should == 'Rammstein - Mutter (2001)'
  end
end
