class CreateUserDashboards < ActiveRecord::Migration[7.0]
  def change
    create_table :user_dashboards do |t|
      t.integer :user_id
      t.integer :dashboard_id
      t.integer :permission

      t.timestamps
    end
  end
end
