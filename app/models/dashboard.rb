class Dashboard < ApplicationRecord
  belongs_to :notification
  has_many :user_dashboard
  has_many :card

  validates :display_name, presence: true, length: {maximum:50}
  validates :dashboard_type, presence: true
  validates :page, presence: true

  def new_attr
    {
      id: self.id,
      display_name: self.display_name,
      dashboard_type: self.dashboard_type,
      page: self.page
    }
  end
end
