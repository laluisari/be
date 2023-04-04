class DbConnection < ApplicationRecord
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
