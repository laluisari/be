class ApplicationController < ActionController::API
  include JsonWebToken
  include DbConnect

  before_action :authenticate_request
  # before_action :db_connect

  attr_reader :current_user

  private

  def authenticate_request
    @current_user = JsonWebToken::AuthorizeApiRequest(request.headers)
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
