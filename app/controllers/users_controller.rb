class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[create login confirm_email forgot_password ]
  before_action :find_user_id, only: %i[show update destroy]

  def active_user
    render json: @current_user.new_attributes, status: :ok
  end

  def login
    @user = User.find_by(email: params[:email])
    # return render json: @user
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { status: 200, message: 'success', user: @user.new_attributes, token: token }, status: :ok
    else
      render json: {
        status: 401,
        message: 'Login Failed',
        error: 'Invalid username or password'
      }, status: :unauthorized
    end
  end

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
      render json: { message: "success", data: @user.new_attributes}, status: :created
    else
      render json: {
               message: @user.errors.full_messages
             },
             status: :unprocessable_entity
    end
  end

  def update
    @user.skip_password_validation = true
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: {
               message: @user.errors.full_messages
             },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: { message: "success", data: @user }, status: :ok
    else
      render json: { message: "Delete Failed" }, status: :unprocessable_entity
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      #tambah view untuk success_confirmation (kasih button untuk redirect ke login page)
      render json: "Email Terverifikasi"
      # redirect_to ...
    else
      render json: { errors: "Email gagal diverifikasi" }, status: :bad_request
    end
  end

  def forgot_password
    user = User.find_by(email: params[:email])
    if user.present?
      user.generate_reset_token
      UserMailer.forgot_password(user).deliver_now
      render json: {
               status: "SUCCESS",
               message: "Password reset email sent"
             },
             status: :ok
    else
      render json: {
               status: "ERROR",
               message: "Email not found"
             },
             status: :unprocessable_entity
    end
  end

  private

  def find_user_id
    @user = User.find_by_id(params[:id])
    if @user.nil?
      render json: { message: "user_id not found" }, status: :not_found
    end
  end

  def user_params 
    params.permit(:name, :email, :password, :password_confirmation, :accept_policy, :gender, :role, :phone_number, :occupation, :avatar)
  end

  def encode_avatar(avatar)
    return nil unless avatar

    User.new.encode_avatar(avatar)
  end

end