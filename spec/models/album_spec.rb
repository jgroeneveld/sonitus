require 'spec_helper'

describe Album do
  include CarrierWave::Test::Matchers

  it { should validate_presence_of :title }
  it { should validate_presence_of :artist }
  it { should validate_presence_of :year }

  describe '#image' do
    let (:album) { Fabricate :album_with_image }

    it 'should be able to attach an image file' do
      saved_path = Rails.root.join(album.image.path)
      Pathname.new(saved_path).should be_exist
    end

    it 'defaults to a size of 580x580' do
      album.image.should have_dimensions(580,580)
    end

    it 'saves a for_collection version of the image' do
      saved_path = Rails.root.join(album.image.for_collection.path)
      Pathname.new(saved_path).should be_exist

      album.image.for_collection.should have_dimensions(220, 220)
    end
  end
end
