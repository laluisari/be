class UserDashboardController < ApplicationController
  before_action :set_user_dashboard, only: [:show, :update, :destroy]

  def index
    @user_dashboards = UserDashboard.all
    render json: @user_dashboards.map(&:new_attr), status: :ok
  end

  def show
    render json: @user_dashboards.new_attr, status: :ok
  end

  def create
    @user_dashboards = UserDashboard.new(user_dashboard_params)
    return render json: { message: 'Failed' }, status: :unprocessable_entity unless @user_dashboards.save

    render json: @user_dashboards.map(&:new_attr), status: :ok
  end

  def update
    unless @user_dashboards.update(user_dashboard_params)
      render json: { message: 'Update Failed' }, status: :unprocessable_entity
      return
    end
    render json: @user_dashboards, status: :ok
  end

  def destroy
    unless @user_dashboards
      render json: { message: 'Delete Failed' }, status: :unprocessable_entity
      return
    end
    render json: @user_dashboards, status: :ok
  end

  private

  def user_dashboard_params
    params.require(:user_dashboards).permit(:user_id, :dashboard_id, :permission)
  end

  def set_user_dashboard
    @user_dashboards = UserDashboard.find_by_id(params[:id])
    return render json: { message: 'Recorn Not Found' }, status: :not_found if @user_dashboards.nil?
  end
end
