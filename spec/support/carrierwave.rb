# ueberschreibt den speicherpfad der bilder und loescht nach der spec ausfuehrung diesen wieder

class AlbumImageUploader < CarrierWave::Uploader::Base
  def store_dir
    Rails.root.join("spec", "support", "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}")
  end
end

RSpec.configure do |config|
  config.after(:all) do
    if Rails.env.test?
      FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
    end
  end
end
