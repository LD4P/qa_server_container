class RenameCronAuthorityStatusToAuthorityStatus < ActiveRecord::Migration[5.1]
  def change
    rename_table :cron_authority_status, :authority_status
  end
end
