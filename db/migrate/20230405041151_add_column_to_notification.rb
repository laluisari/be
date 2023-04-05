class AddColumnToNotification < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :dashboard_id, :integer
  end
end
