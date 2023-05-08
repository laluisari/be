class CsvUploader < CarrierWave::Uploader::Base
  
  include Cloudinary::CarrierWave
  
  def extension_allowlist
    %w(csv)
  end
end
