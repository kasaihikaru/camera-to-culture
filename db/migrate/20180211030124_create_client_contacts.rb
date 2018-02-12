class CreateClientContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :client_contacts do |t|
      t.references :client, index: true, foreign_key: true
      t.string  :tel
      t.string  :address
      t.boolean :is_deleted, default:false, null:false
      t.timestamps
    end
  end
end
