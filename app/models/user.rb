class User < ApplicationRecord
  #roles
  enum role: {
    admin: 0,
    member: 1,
    data_expert: 2
  }

  #validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 3}, if: -> { new_record? || !password.nil? }
  validates :role, presence: true
end
