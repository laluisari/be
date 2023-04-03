class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :frequency
      t.date    :day
      t.time    :time
      t.string  :description
      t.timestamps
    end
  end
end
