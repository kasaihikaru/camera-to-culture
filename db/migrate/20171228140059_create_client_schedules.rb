class CreateClientSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :client_schedules do |t|
      t.references :client, index: true, foreign_key: true
      t.date    :date, null:false
      t.text    :schedule
      t.boolean :is_deleted, null:false, default:false
      t.timestamps
    end
  end
end