require 'spec_helper'

describe Album do
  it '#long_title' do
    album = Album.new title: "Mutter", artist: "Rammstein", year: 2001
    album.long_title.should == 'Rammstein - Mutter (2001)'
  end

  it { should validate_presence_of :title }
  it { should validate_presence_of :artist }
  it { should validate_presence_of :year }
end
