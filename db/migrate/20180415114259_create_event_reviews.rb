class CreateEventReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :event_reviews do |t|
      t.references :event, index: true, foreign_key: true
      t.text    :cl_review
      t.text    :cl_comment
      t.text    :cs_review
      t.integer :stars
      t.string  :cs_image_1
      t.string  :cs_image_2
      t.string  :cs_image_3
      t.string  :cs_image_4
      t.string  :cs_image_5
      t.timestamps
    end
  end
end
