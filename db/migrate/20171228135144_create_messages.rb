class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :sender_id, null:false, index: true
      t.integer :reciever_id, null:false, index: true
      t.text    :message
      t.boolean :sender_read, default:false, null:false
      t.boolean :reciever_read, default:false, null:false
      t.timestamps
    end
  end
end