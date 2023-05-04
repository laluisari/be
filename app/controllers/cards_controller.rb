class CardsController < ApplicationController
    before_action :set_card, only: [:show, :update, :destroy]
  
    def index 
      @cards = Card.all
      render json: @cards, status: :ok
    end 
  
    def create 
      @card = Card.new(card_params)
      
      if @card.save 
        render json: { message: "Card created", card: @card }, status: :created 
      else 
        render json: { message: "Card creation failed", errors: @card.errors }, status: :unprocessable_entity
      end 
    end 
  
    def update 
        if @card.update(card_params)
          render json: { message: "Card update succeeded", card: @card}
        else  
          render json: { message: "Card update failed", errors: @card.errors }, status: :unprocessable_entity
        end 
      end 
      
  
    def destroy 
      if @card.destroy!
        render json: { message: 'Card deleted' }, status: :ok
      else
        render json: { message: 'Card deletion failed' }, status: :unprocessable_entity
      end
    end
  
    private  
  
    def set_card 
      @card = Card.find(params[:id])
    end
  
    def card_params 
      params.require(:card).permit(:query, :visualization_type, :dashboard_pages_id, :owner_id, :db_connection_id, :position, :configuration, :card_type)
    end
  end
  