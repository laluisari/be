class CardsController < ApplicationController
    before_action :card_id , only: [:show, :update, :destroy] 

    def index 
        @cards = Card.all()
        render json: @cards, status: :ok
    end 

    def create 
        @query = Card.new(card_params)
        
        if @query.save 
            return render json: @query, status: :created 
        else 
            return render json: @query.errors, status: :unprocessable_entity
        end 
    end 

    def update 
        if @card.update(card_params)
            return render json: @card 
        else  
            return render json: @card.errors , status: :unprocessable_entity
        end 
    end

    def destroy 
        unless @card.destroy
            return render json: { message: 'Delete Failed' }, status: :unprocessable_entity
            
        end
           render json: @card, status: :ok
    end

    private  

    def card_id 
        @order_id = Order.find(params[:id])
    end

    def card_params 
        params.require(:card).permit(:query, :visualization_type, :dashboard_id, :owner_id, :db_connection_id, :position, :configuration, :card_type)
    end
      
end
