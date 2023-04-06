class NotificationsController < ApplicationController
    before_action :set_notification, only: [:show, :destroy]

  # GET /notifications
  def index
    @notifications = Notification.all

    render json: @notifications.map { |notification| notification.new_attr }
  end

  # GET /notifications/1
  def show
    render json: @notification.new_attr
  end

  # POST /notifications
  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      render json: @notification.new_attr, status: :created
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notifications/1
  def destroy
    @notification = Notification.find(params[:id])
    if @notification
        @notification.destroy
        render json:{messages:'Notification successfully deleted' }, status:200
    else
        render error:{error:'Unable to delete Notification.'}, status:400
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find_by_id(params[:id])
      if @notification.nil?
        render json: { error: "Notification not found" }, status: :not_found
      end
    end

    # Only allow a trusted parameter "white list" through.
    def notification_params
      params.require(:notification).permit(:frequency, :day, :time, :dashboard_id, :description)
    end
end
