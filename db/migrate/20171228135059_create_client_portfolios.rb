class CreateClientPortfolios < ActiveRecord::Migration[5.1]
  def change
    create_table :client_portfolios do |t|
      t.references :client, index: true, foreign_key: true
      t.string :image
      t.boolean :is_deleted, default:false, null:false
      t.timestamps
    end
  end
end
