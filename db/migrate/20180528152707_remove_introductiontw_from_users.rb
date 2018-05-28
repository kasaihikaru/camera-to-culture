class RemoveIntroductiontwFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :introduction_tw, :text
  end
end
