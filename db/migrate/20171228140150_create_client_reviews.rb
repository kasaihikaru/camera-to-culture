class CreateClientReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :client_reviews do |t|
      t.references :client, index: true, foreign_key: true
      t.references :customer, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.text    :review
      t.timestamps
    end
  end
end
