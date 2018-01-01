class CreateClientLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :client_locations do |t|
      t.references :client, index: true, foreign_key: true
      t.references :country, index: true, foreign_key: true
      t.references :prefecture, index: true, foreign_key: true
      t.timestamps
    end
  end
end