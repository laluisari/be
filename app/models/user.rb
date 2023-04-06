class User < ApplicationRecord
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
  # has_many :card
  # has_many :order 

  #validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}, if: -> { new_record? || !password.nil? }
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
        role: self.role
    }
  end
end 
