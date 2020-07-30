class DropUnusedTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :authority_status_failure
    drop_table :authority_status
  end
end
