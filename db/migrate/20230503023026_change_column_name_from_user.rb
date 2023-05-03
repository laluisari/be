class ChangeColumnNameFromUser < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :avatar, :text
  end
end
