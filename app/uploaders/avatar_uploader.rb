class AvatarUploader < CarrierWave::Uploader::Base

    include Cloudinary::CarrierWave
  
    process :convert => 'jpg'
    process :tags => ['post_picture']
  
    version :thumbnail do
      eager
      resize_to_fit(150, 150)
      cloudinary_transformation :quality => 80          
    end  
  
  
  end