require 'csv'
require 'cloudinary'

class GeneratesController < ApplicationController
  skip_before_action :authenticate_request

  def upload
    file = params[:file]
    begin
      uploader = CsvUploader.new
      uploader.store!(file)
      render json: { message: "File uploaded successfully!" }
    rescue => e
    
      render json: { message: "Failed to upload file. Error: #{e.message} " }, status: :unprocessable_entity
    end
  end

  private

  def generates_params
    params.permit(:file)
  end
end


# def upload
#   uploader = CsvUploader.new
#   uploader.store!(params[:file])
#   cloudinary_url = uploader.url
#   file_contents = open(cloudinary_url).read 

#   if file_contents.nil?
#     render json: {message: "error: no file selected"}
#   else
#     csv_data = CSV.parse(file_contents, headers: true)
#     array_of_hashes = csv_data.map(&:to_hash)

#     array_of_hashes.each do |connection_info|
#       # campur makek code afan
#       conn = DbConnect.InitConnection(connection_info)

#       if conn.nil?
#         render json: {message: "error: failed to connect to database with #{connection_info.inspect}"}
#         return
#       end
#       # Perform any necessary database operations here using the 'conn' object
#       conn.close
#     end

#     # Redirect the user to a success page
#     render json: "berhasil", status: :ok
#   end
# end