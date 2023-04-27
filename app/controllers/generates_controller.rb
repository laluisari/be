require 'csv'
class GeneratesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index 
    render "generates/index"
  end

  def upload
    file_contents = File.read(params[:file].tempfile)
    if file_contents.nil?
      render json: {message: "error: no file selected"}
    else
      csv_data = CSV.parse(file_contents, headers: true)
      array_of_hashes = csv_data.map(&:to_hash)
      
      array_of_hashes.each do |connection_info|
        # Connect to the database using the connection information
        conn = DbConnect.InitConnection(connection_info)
        
        if conn.nil?
          render json: {message: "error: failed to connect to database with #{connection_info.inspect}"}
          return
        end
        
        # Perform any necessary database operations here using the 'conn' object
        
        conn.close
      end
      
      # Redirect the user to a success page
      render json: "berhasil", status: :ok
    end
  end

  def generates_params
    params.permit(:file)
  end
end
