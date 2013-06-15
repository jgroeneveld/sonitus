require 'spec_helper'

describe Album do
  it { should validate_presence_of :title }
  it { should validate_presence_of :artist }
  it { should validate_presence_of :year }

  describe '#long_title' do
    it 'generates a long title' do
      album = Album.new title: "Mutter", artist: "Rammstein", year: 2001
      album.long_title.should == 'Rammstein - Mutter (2001)'
    end
  end
end
