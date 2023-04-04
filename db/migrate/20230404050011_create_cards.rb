class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.text :query
      t.integer :visualization_type, default: 0
      t.references :dashboard, null: false, foreign_key: {to_table: :dashboard, on_delete: :cascade}
      t.references :owner, null: false, foreign_key: {to_table: :users, on_delete: :cascade}
      t.references :db_connection, null: false, foreign_key: {to_table: :db_connection, on_delete: :cascade}
      t.json :position
      t.json :configuration
      t.string :card_type 

      t.timestamps
    end
  end
end
