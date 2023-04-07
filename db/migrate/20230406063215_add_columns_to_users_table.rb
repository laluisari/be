class AddColumnsToUsersTable < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone_number, :bigint, null: true
    add_column :users, :occupation, :string, null: true
  end
end
