require 'spec_helper'

describe Album do
  it { should validate_presence_of :title }
  it { should validate_presence_of :artist }
  it { should validate_presence_of :year }

  describe '#image' do
    it 'should be able to attach an image file' do
      album = Fabricate :album
      album.image = File.open(Rails.root.join('spec', 'fixtures', 'album_image.gif'))
      album.save!

      saved_path = Rails.root.join(album.image.path)
      Pathname.new(saved_path).should be_exist
    end
  end
end
