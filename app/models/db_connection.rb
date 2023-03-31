class DbConnection < ApplicationRecord
  belongs_to :user
  has_many :dashboards

  validates :display_name, presence: true, length: { minimum: 5, maximum: 100 }
  validates :db_name, presence: true, length: { minimum: 0, maximum: 256 }
  validates :db_port, presence: true, numericality: { only_integer: true }
  validates :db_user, presence: true, length: { minimum: 0, maximum: 256 }
  validates :db_pass, presence: true, length: { minimum: 0, maximum: 256 }

  enum connection_type: {
    mysql: 0,
    postgresql: 1,
    csv: 2,
    google_analytic: 3
  }

  def new_attr
    {
      id: self.id,
      user: self.user_id,
      display_name: self.display_name,
      db_port: self.db_port,
      db_name: self.db_name,
      db_user: self.db_user,
      db_pass: self.db_pass,
      analytics_account_id: self.analytics_account_id,
      json_file: self.json_file,
      csv_file: self.csv_file
    }
  end
end
