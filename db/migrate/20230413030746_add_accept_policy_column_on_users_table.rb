class AddAcceptPolicyColumnOnUsersTable < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :accept_policy, :boolean, :default => false
  end
end
