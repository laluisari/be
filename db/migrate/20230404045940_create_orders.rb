class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: { to_table: :users, on_delete: :cascade }
      t.references :data_expert, null: false, foreign_key: { to_table: :users, on_delete: :cascade }
      t.bigint :status
      t.bigint :price
      t.timestamps

    end
 

  end
end
