class AddLinewechatToClientContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :client_contacts, :line_id, :string
    add_column :client_contacts, :wechat_id, :string
  end
end
