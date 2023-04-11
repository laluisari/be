class AddColumnDbHostToDbConnection < ActiveRecord::Migration[7.0]
  def change
    add_column :db_connections, :db_host, :string, :after => :connection_type
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
