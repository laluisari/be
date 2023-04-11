class User < ApplicationRecord
  before_create :confirmation_token

  #roles
  enum role: {
    admin: 0,
    customer: 1, 
    data_expert: 2  
  }

  #relations
  has_many :db_connections
  has_many :user_dashboards
  has_many :dashboards, through: :user_dashboards
  has_many :cards, foreign_key: :owner_id
  has_many :orders, foreign_key: :customer_id  
  has_many :orders, foreign_key: :data_expert_id  

  #validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: {minimum: 6}, if: -> { new_record? || !password.nil? }
  validates :role, presence: true

  #bcrypt to encrypt password
  has_secure_password

  #new_attributes
  def new_attributes
    {
        id: self.id,
        name: self.name,
        email: self.email,
        password_digest: self.password_digest, 
        role: self.role,
        phone_number: self.phone_number,
        occupation: self.occupation
    }
  end

  #registration with email confirmation
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  #set_token
  
  def generate_reset_token 
    self.reset_token = SecureRandom.hex(10)
    self.reset_sent_at = Time.now.utc 
    save! 
  end

  private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
<<<<<<< HEAD

  
end 
=======
end
>>>>>>> 28512b0f02f5eb69fd21dbca12a8093444acc83a
