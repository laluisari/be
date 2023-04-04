class UserDashboard < ApplicationRecord
  enum connection_type: {
    owner: 0,
    read: 1,
    modify: 2
  }
  belongs_to :user
  belongs_to :dashboard

  validates :user_id, presence: true
  validates :dashboard_id, presence: true
  validates :permission, presence: true
  def new_attr
    {
      user_id: self.user_id,
      dashboard_id: self.dashboard_id,
      permission: self.permission
    }
  end
end
