class CreatePrefectures < ActiveRecord::Migration[5.1]
  def change
    create_table :prefectures do |t|
    	t.string  :area, null:false
      t.string  :ja, null:false
      t.string  :en, null:false
      t.string  :zh, null:false
      t.string  :tw, null:false
    end
  end
end