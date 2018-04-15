class CreateEventStates < ActiveRecord::Migration[5.1]
  def change
    create_table :event_states do |t|
      t.references :event, index: true, foreign_key: true
      t.string  :state, null:false
      t.text    :comment
      #read/unread
      t.boolean :cl_read, default:false, null:false
      t.boolean :cs_read, default:false, null:false
      t.timestamps
    end
  end
end