class Dashboard < ApplicationRecord
  has_one :notification
  has_many :user_dashboard
  has_many :card
  has_many :user_dashboards
  has_many :users, through: :user_dashboards

  validates :display_name, presence: true, length: {maximum:50}
  validates :dashboard_type, presence: true
  validates :page, presence: true
  validates :thumbnail, presensce: true
  validates :db_connection_id, presensce: true

  def new_attr
    {
      id: self.id,
      display_name: self.display_name,
      dashboard_type: self.dashboard_type,
      page: self.page,
      thumbnail: self.thumbnail,
      db_connection_id: self.db_connection_id

    }
  end
end
