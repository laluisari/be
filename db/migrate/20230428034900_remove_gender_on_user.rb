class RemoveGenderOnUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :gender
  end
end
