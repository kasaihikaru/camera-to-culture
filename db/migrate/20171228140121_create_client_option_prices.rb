class CreateClientOptionPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :client_option_prices do |t|
      t.references :client, index: true, foreign_key: true
      t.string  :name, null:false
      t.boolean :along_with_time, default:false, null:false
      t.integer :price
      t.boolean :is_deleted, default:false, null:false
      t.timestamps
    end
  end
end