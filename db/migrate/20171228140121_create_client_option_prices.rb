class CreateClientOptionPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :client_option_prices do |t|
      t.references :client, index: true, foreign_key: true
      t.string  :name, null:false
      t.integer :arithmetic_type, null:false
      t.integer :add_sub_price
      t.float :mul_div_percent
      t.boolean :is_deleted, default:false, null:false
      t.timestamps
    end
  end
end
