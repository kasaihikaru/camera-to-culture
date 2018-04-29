class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.references :user, index: true, foreign_key: true
      t.text    :introduction
      t.datetime :deleted_at
      t.timestamps
    end
  end
end