class RemoveNameFromClientContacts < ActiveRecord::Migration[5.1]
  def change
    remove_column :client_contacts, :name, :integer
    add_column :client_contacts, :name, :string
  end
end
