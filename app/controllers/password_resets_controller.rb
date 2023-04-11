class PasswordResetsController < ApplicationController

  def edit
    @user = User.find_by(reset_token: params[:token])
    if @user.present? && @user.reset_sent_at > 2.hours.ago.utc 
      render json: "ini ganti dengan render views input"
    else
      render json: { status: 'ERROR', message: 'Invalid token' }, status: :unprocessable_entity
    end
  end
  

      def update

        @user = User.find_by(reset_token: params[:token])
        if @user.present? && @user.reset_sent_at > 2.hours.ago.utc && @user.update(user_params)
          render json: { status: 'SUCCESS', message: 'Password reset' }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Invalid token or password not reset' }, status: :unprocessable_entity
        end
      end
        
      private
    
      def user_params
        params.require(:user).permit(:password, :password_confirmation)
      end
end
