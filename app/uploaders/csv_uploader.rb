class CsvUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # Add an allowlist of extensions which are allowed to be uploaded.
  def extension_allowlist
    %w(csv)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
