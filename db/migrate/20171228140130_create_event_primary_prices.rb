class CreateEventPrimaryPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :event_primary_prices do |t|
      t.references :event, index: true, foreign_key: true
      t.references :client_primary_price, index: true, foreign_key: true
      t.integer :hours, null:false
      t.integer :price_sum, null:false
      t.timestamps
    end
  end
end
