class CreateClientPrimaryPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :client_primary_prices do |t|
      t.references :client, index: true, foreign_key: true
      t.integer :price_per_hour, null:false
      t.integer :minimum_hours, null:false, default:"1"
      t.datetime :deleted_at
      t.timestamps
    end
  end
end