class DashboardsController < ApplicationController
  before_action :set_dashboard, only: [:show, :update, :destroy]

  def index
    @dashboards = Dashboard.all

    render json: @dashboards.map(&:new_attr), status: :ok
  end

  def show
    render json: @dashboard.new_attr, status: :ok
  end

  def create
    @dashboard = Dashboard.new(dashboard_params)
    return render json: { message: 'Failed'}, status: :unprocessable_entity unless @dashboard.save

    render json: @dashboard.new_attr, status: :ok
  end

  def update
    unless @dashboard.update(dashboard_params)
      render json: { message: 'Update Failed' }, status: :unprocessable_entity
      return
    end
    render json: @dashboard, status: :ok
  end

  def destroy
    unless @dashboard.destroy
      render json: { message: 'Delete Failed' }, status: :unprocessable_entity
      return
    end
    render json: @dashboard, status: :ok
  end

  private

  def  dashboard_params
    params.require(:dashboard).permit(:display_name, :dashboard_type, :thumbnail, :page, :db_connection_id)
  end

  def set_dashboard
    @dashboard = Dashboard.find_by_id(params[:id])
    return render json: { message: 'Record Not Found' }, status: :not_found if @dashboard.nil?
  end

end
