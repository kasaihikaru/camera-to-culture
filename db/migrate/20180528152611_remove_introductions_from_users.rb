class RemoveIntroductionsFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :introduction_ja, :text
    remove_column :users, :introduction_en, :text
    remove_column :users, :introduction_zh, :text
  end
end
