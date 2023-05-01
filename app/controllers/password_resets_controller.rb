require "dotenv/load"
class PasswordResetsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[edit update]

  def edit
    @user = User.find_by(reset_token: params[:token])
    if @user.present? && @user.reset_sent_at > 2.hours.ago.utc
      url = "#{ENV["URL_RESET_PASSWORD"]}/#{@user.reset_token}"
      redirect_to url, allow_other_host: true
    else
      render json: {
               status: 200,
               message: "Invalid token"
             },
             status: :unprocessable_entity
    end
  end

  def update
    @user = User.find_by(reset_token: params[:token])
    if @user.present? && @user.reset_sent_at > 2.hours.ago.utc &&
         @user.update(user_params)
      render json: { status: "SUCCESS", message: "Password reset" }, status: :ok
    else
      render json: {
               status: 422,
               message: "Invalid token or password not reset",
               error: @user.errors
             },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:password, :password_confirmation)
  end
end
