class RemoveBirthdateOnUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :birthdate
  end
end
