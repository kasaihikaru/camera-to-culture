class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string  :ja_group, null:false
      t.string  :ja, null:false
      t.string  :en_group, null:false
      t.string  :en, null:false
      t.string  :zh_group, null:false
      t.string  :zh, null:false
      t.string  :tw_group, null:false
      t.string  :tw, null:false
    end
  end
end