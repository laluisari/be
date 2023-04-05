class User < ApplicationRecord
  #roles
  enum role: {
    admin: 0,
    member: 1,
    data_expert: 2
  }

  #relations


  #validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6}, if: -> { new_record? || !password.nil? }
  validates :role, presence: true

  #bcrypt to encrypt password
  has_secure_password

  #new_attributes
  def new_attributes
    {
        id: self.id,
        name: self.name,
        email: self.email,
        password: self.password,
        role: self.role
    }
  end
end
