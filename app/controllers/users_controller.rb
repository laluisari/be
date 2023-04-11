class UsersController < ApplicationController
  before_action :find_user_id, only: [:show, :update, :destroy]

  def index
    @users = User.all

    render json: @users.map(&:new_attributes), status: :ok
  end
  
  def show
    render json: { message: "success", data: @user.new_attributes }, status: :ok
  end

  def create
    @user = User.create(user_params)

    if @user.valid?
      UserMailer.registration_confirmation(@user).deliver_now
      render json: { message: "success", data: @user }, status: :created
    else
      render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update 
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
    end 
  end

  def destroy
    @user.destroy

    render json: { message: "success", data: @user.destroy }, status: :ok
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      render json: "Email Terverifikasi"
    else
      render json: { errors: "Email gagal diverifikasi" }, status: :bad_request
    end
  end

  def forgot_password 
    user = User.find_by(email: params[:email])
    if user.present?
      user.generate_reset_token
      UserMailer.forgot_password(user).deliver_now
      render json: { status: 'SUCCESS', message: 'Password reset email sent' }, status: :ok
    else 
      render json: { status: 'ERROR', message: 'Email not found' }, status: :unprocessable_entity
    end
  end 


  private

  def find_user_id
    @user = User.find_by_id(params[:id])

    render json: { message: "user_id not found" }, status: :not_found if @user.nil?
  end

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :password_confirmation, :role, :phone_number, :occupation
    )
  end
  
end
