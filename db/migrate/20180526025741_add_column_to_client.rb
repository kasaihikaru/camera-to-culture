class AddColumnToClient < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :deliverables, :text
  end
end
