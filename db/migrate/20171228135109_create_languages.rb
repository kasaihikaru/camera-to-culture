class CreateLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :languages do |t|
      t.string  :ja, null:false
      t.string  :ja_s, null:false
      t.string  :en, null:false
      t.string  :en_s, null:false
      t.string  :zh, null:false
      t.string  :zh_s, null:false
      t.string  :tw, null:false
      t.string  :tw_s, null:false
    end
  end
end