class ChangeColumnAvatarFromUser < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :avatar, :string
  end
end
