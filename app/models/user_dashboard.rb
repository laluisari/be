class UserDashboard < ApplicationRecord
  def new_attr
    {
      user_id: self.user_id,
      dashboard_id: self.dashboard_id,
      permission: self.permission,
    }
  end
end
