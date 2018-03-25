class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :client, index: true, foreign_key: true
      t.references :customer, index: true, foreign_key: true
      t.datetime    :start_time, null:false
      t.datetime    :end_time, null:false
      t.integer :total_price
      t.integer :primary_price_sum
      t.integer :option_price_sum
      t.timestamps
    end
  end
end