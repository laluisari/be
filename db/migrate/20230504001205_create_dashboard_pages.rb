class CreateDashboardPages < ActiveRecord::Migration[7.0]
  def change
    create_table :dashboard_pages do |t|
      t.references :dashboard, null:false, foreign_key: {to_table: :dashboards, on_delete: :cascade}
      t.integer :type_pages, null:false
      t.timestamps
    end
  end
end
