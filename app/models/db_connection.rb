class DbConnection < ApplicationRecord

  belongs_to :user
  has_many :dashboards

  validates :display_name, presence: true, length: { minimum: 5, maximum: 100 }
  validates :db_name, presence: true, length: { minimum: 0, maximum: 256 }, if: :db_type?
  validates :db_port, presence: true, numericality: true, if: :db_type?
  validates :db_user, presence: true, length: { minimum: 0, maximum: 256 }, if: :db_type?
  validates :db_pass, presence: true, length: { minimum: 0, maximum: 256 }, if: :db_type?

  enum connection_type: {
    mysql: 0,
    postgresql: 1,
    csv: 2,
    google_analytic: 3
  }

  belongs_to :user

  #upload csv
  mount_uploader :csv_file, CsvUploader

  def new_attr
    {
      id: self.id,
      user: self.user&.new_attributes,
      display_name: self.display_name,
      db_host: self.db_host,
      db_port: self.db_port,
      db_name: self.db_name,
      db_user: self.db_user,
      db_pass: self.db_pass,
      analytics_account_id: self.analytics_account_id,
      json_file: self.json_file,
      csv_file: self.csv_file
    }
  end

  def db_type?
    connection_type == 'mysql' || connection_type == 'postgresql'
  end
end

# db = DbConnection.new(user_id: 1, display_name: 'mysql2', connection_type: 'mysql', db_host: 'sql12.freemysqlhosting.net',db_port: 3306, db_name: 'sql12611619', db_user: 'sql12611619', db_pass: 'hCCBm9HuGx')
