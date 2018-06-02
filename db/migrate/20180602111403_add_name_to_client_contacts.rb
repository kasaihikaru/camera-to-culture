class AddNameToClientContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :client_contacts, :name, :integer
  end
end
