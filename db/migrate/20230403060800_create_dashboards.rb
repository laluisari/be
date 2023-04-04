class CreateDashboards < ActiveRecord::Migration[7.0]
  def change
    create_table :dashboards do |t|
      t.string :display_name
      t.string :dashboard_type
      t.integer :page

      t.timestamps
    end
  end
end
