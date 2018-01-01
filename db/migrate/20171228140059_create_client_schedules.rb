class CreateClientSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :client_schedules do |t|
      t.references :client, index: true, foreign_key: true
      t.date    :day_off, null:false
      t.timestamps
    end
  end
end