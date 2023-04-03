class Notification < ApplicationRecord

    # belongs_to: dashboard

    # validates :frequency, presence: true
    # validates :day, presence: true
    # validates :time, presence: true
    # validates :description, presence: true, length: { maximum: 300 }

    enum frequency:{
        daily: 1,
        weekly: 2,
        monthly: 3
        }


    def new_attr
        {
          id: self.id,
          frequency: self.frequency,
          day: self.day,
          time: self.time,
          dashboard: self.dashboard,
          description: self.description,
        }
      end
end
