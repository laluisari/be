class Order < ApplicationRecord
    belongs_to :customer, class_name: "User"
    belongs_to :data_expert, class_name: "User"

    validates :customer, presence: true
    validates :data_expert, presence: true
    validates :status, presence: true
    validates :price, presence: true
    validate :valid_customer_role
    validate :valid_data_expert_role

    private 

    def valid_customer_role 
        if customer && customer.role != "customer"
            errors.add(:customer, "must be a customer")
        end
    end

    def valid_data_expert_role 
        if data_expert && data_expert.role != "data_expert"
            errors.add(:data_expert, "must be a data_Expert")
        end
    end
        
end
