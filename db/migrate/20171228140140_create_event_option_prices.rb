class CreateEventOptionPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :event_option_prices do |t|
      t.references :event, index: true, foreign_key: true
      t.references :client_option_price, index: true, foreign_key: true
      t.integer :numbers, null:false, default:"1"
      t.integer :price_sum, null:false
      t.timestamps
    end
  end
end
