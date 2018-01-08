class RemoveNameToCategories < ActiveRecord::Migration[5.1]
  def change
    remove_column :categories, :name, :string
    add_column :categories, :ja, :string, null:false
    add_column :categories, :en, :string, null:false
    add_column :categories, :zh, :string, null:false
    add_column :categories, :tw, :string, null:false
  end
end