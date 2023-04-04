class Card < ApplicationRecord

    belongs_to :dashboard
    belongs_to :owner, class_name: "User"
    
    has_many :db_connection
  
    enum visualization_type: { bar: 0, pie: 1, line: 2 }
  
    validates :visualization_type, presence: true
    validates :query, presence: true
    validates :card_type, presence: true
  
    validate :valid_owner_role
  
    private
  
    def valid_owner_role
      if owner && owner.role != "owner"
        errors.add(:owner, "must be an owner")
      end
    end

end
