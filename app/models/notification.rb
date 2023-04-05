class Notification < ApplicationRecord

    # belongs_to: dashboard

    # validates :frequency, presence: true
    # validates :day, presence: true
    # validates :time, presence: true
    # validates :description, presence: true, length: { maximum: 300 }

    enum frequency:{
        daily: 0,
        weekly: 1,
        monthly: 2
        }


    def new_attr
        {
          id: self.id,
          frequency: self.frequency,
          day: self.day,
          time: self.time,
          dashboard_id: self.dashboard_id,
          description: self.description,
        }
      end
end
