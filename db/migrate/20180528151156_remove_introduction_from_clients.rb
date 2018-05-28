class RemoveIntroductionFromClients < ActiveRecord::Migration[5.1]
  def change
    remove_column :clients, :introduction, :text
  end
end
