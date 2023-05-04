class DashboardPage < ApplicationRecord
    belongs_to :dashboard
    has_many :card
end
