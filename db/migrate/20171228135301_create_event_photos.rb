class CreateEventPhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :event_photos do |t|
      t.references :event, index: true, foreign_key: true
      t.string :image
      t.boolean :is_deleted, default:false, null:false
      t.timestamps
    end
  end
end