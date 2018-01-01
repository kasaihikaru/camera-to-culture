class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.references :user, index: true, foreign_key: true
      t.text    :introduction
      t.text    :camera
      t.boolean :is_deleted, default:false, null:false
      t.timestamps
    end
  end
end