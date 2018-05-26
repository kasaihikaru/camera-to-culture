class AddIntroductionsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :introduction_ja, :text
    add_column :users, :introduction_en, :text
    add_column :users, :introduction_zh, :text
    add_column :users, :introduction_tw, :text
  end
end
