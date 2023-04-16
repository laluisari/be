class OrdersController < ApplicationController
    before_action :order_id, only: [:show, :update, :destroy]
    skip_before_action :authenticate_request

    def index 
        @orders = Order.all 
        return render json: @orders
    end

    def show 
        return render json: @order_id
    end

    def show_customer
        @orders = Order.where(customer_id: params[:customer_id])
        return render json: @orders
    end

    def show_data_expert
        @orders = Order.where(data_expert_id: params[:data_expert_id])
       return  render json: @orders
    end

    def create 
        @order = Order.new(order_params)

        if @order.save 
            return render json: @order, status: :created 
        else 
            return render json: @order.errors, status: :unprocessable_entity
        end 
    end 

    def update 
        if @order_id.update(order_params)
            return render json: @order_id
        else 
            return render json: @order_id.errors, status: :unprocessable_entity
        end 
    end 

    def destroy
        @order.destroy 
        return render json: "berhasil di hapaus"
    end 

    private 

    def order_id
        @order_id = Order.find(params[:id])
    end

    def order_params 
        params.require(:order).permit(:customer_id, :data_expert_id, :status, :price)
    end
    
end
