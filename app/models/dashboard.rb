class Dashboard < ApplicationRecord
  def new_attr
    {
      id: self.id,
      display_name: self.display_name,
      dashboard_type: self.dashboard_type,
      page: self.page
    }
  end
end
