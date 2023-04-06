class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[create login]
  before_action :find_user_id, only: [:show, :update, :destroy]

  def login
    @user = User.find_by(email: params[:email])
    # return render json: @user
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: {
        user: @user.new_attributes,
        token: token
      }
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end

  def index
    @users = User.all

    render json: @users.new_attributes, status: :ok
  end

  def show
    render json: { message: "success", data: @user.new_attributes }, status: :ok
  end

  def create
    @user = User.create(user_params)
    @user.role = 'customer'
    if @user.save
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

  private

  def find_user_id
    @user = User.find_by_id(params[:id])

    render json: { message: "user_id not found" }, status: not_found if @user.nil?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end
end
