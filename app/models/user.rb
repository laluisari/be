
class User < ApplicationRecord
  before_create :confirmation_token
  before_save :encode_avatar

  #enum roles and genders
  enum role: {
    admin: 0,
    customer: 1,
    data_expert: 2
  }

  enum gender: {
    laki_laki: 0,
    perempuan: 1
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
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate  :password_requirements, unless: :skip_password_validation
  validates :role, presence: true
  validates :accept_policy, presence: true, on: :create

  #attr_accessor
  attr_accessor :skip_password_validation

  #bcrypt to encrypt password
  has_secure_password

  #uploader cloudinaryy
  mount_uploader :avatar, AvatarUploader

  #new_attributes
  def new_attributes
    {
        id: self.id,
        name: self.name,
        email: self.email,
        gender: self.gender,
        phone_number: self.phone_number,
        occupation: self.occupation,
        avatar: self.avatar,
        role: self.role,
        email_confirmed: self.email_confirmed
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
    save!(validate: false)
  end

  private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  #validation for password
  def password_requirements
    rules = {
      "must contain at least 8 characters"                    => /.{8,}/,
      "must contain at least one lowercase letter"            => /[a-z]+/,
      "must contain at least one uppercase letter"            => /[A-Z]+/,
      "must contain at least one digit"                       => /\d+/,
      "must contain at least one special character or symbol" => /[^A-Za-z0-9]+/
    }

    rules.each do |message, regex|
      errors.add( :password_digest, message ) unless password.match( regex )
    end
  end

end
