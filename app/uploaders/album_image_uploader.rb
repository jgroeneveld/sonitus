# encoding: utf-8

class AlbumImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    if version_name == :for_collection
      "http://placehold.it/220x220"
    else
      "http://placehold.it/580x580"
    end
  end

  process resize_and_pad: [580, 580]

  version :for_collection do
    process resize_and_pad: [220, 220]
  end
end
