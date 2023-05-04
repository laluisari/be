class DashboardPagesController < ApplicationController
    before_action :get_dsbpage, only: [:show, :update, :destroy]
  
    def index 
      @dsbpages = DashboardPage.all
      render json: @dsbpages, status: :ok 
    end 
  
    def create 
      @dsbpage = DashboardPage.new(dsbpage_params)
      if @dsbpage.save 
        render json: {message: "Dashboard pages created", dsbpages: @dsbpage}, status: :created
      else 
        render json: {message: "Dashboard pages creation failed", errors: @dsbpage.errors}, status: :unprocessable_entity
      end
    end 
  
    def update  
      if @dsbpage.update(dsbpage_params)
        render json: { message: "dashboard page successfully edited", dsbpages: @dsbpage}, status: :ok 
      else  
        render json: { message: "dashboard pages failed to edit", errors: @dsbpage.errors}, status: :unprocessable_entity
      end 
    end 
  
    def destroy 
      if @dsbpage.destroy!
        render json: { message: "dashboard pages successfully deleted", dsbpages: @dsbpage}, status: :ok 
      else 
        render json: { message: "dashboard pages failed to delete", errors: @dsbpage.errors}, status: :unprocessable_entity
      end 
    end
  
    private  
  
    def get_dsbpage 
      @dsbpage = DashboardPage.find(params[:id])
    end
  
    def dsbpage_params 
      params.require(:dsbpage).permit(:dashboard_id, :type_pages)
    end
  end
  