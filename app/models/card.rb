class Card < ApplicationRecord 

    belongs_to :dashboard_page
    belongs_to :owner, class_name: "User"
    
    has_many :db_connection
  
    enum visualization_type: { bar: 0, pie: 1, line: 2 }
  
    validates :visualization_type, presence: true
    validates :query, presence: true
    validates :card_type, presence: true
  
    validates :owner_id, presence: :true, on: :create

    validate :owner_id_exists , on: :create

    private 

    def owner_id_exists 
      errors.add(:owner_id) unless User.exists?(id: owner_id)
    end
  


end
