class CreateDbConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :db_connections do |t|
      t.integer :user_id
      t.string :display_name
      t.integer :connection_type
      t.integer :db_port
      t.string :db_name
      t.string :db_user
      t.string :db_pass
      t.integer :analytics_account_id
      t.string :json_file
      t.string :csv_file
      t.timestamps
    end
  end
end
