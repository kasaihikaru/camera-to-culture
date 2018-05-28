class AddIntroductionsToClient < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :introduction_ja, :text
    add_column :clients, :introduction_en, :text
    add_column :clients, :introduction_zh, :text
    add_column :clients, :introduction_tw, :text
    add_column :clients, :message, :text
  end
end
