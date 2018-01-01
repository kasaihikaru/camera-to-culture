class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :client, index: true, foreign_key: true
      t.references :customer, index: true, foreign_key: true
      t.text    :message
      t.boolean :from_cs, default:true, null:false
      t.timestamps
    end
  end
end