class CreateClientPortfolios < ActiveRecord::Migration[5.1]
  def change
    create_table :client_portfolios do |t|
      t.references :client, index: true, foreign_key: true
      t.timestamps
    end
  end
end
