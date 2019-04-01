class AddColumnTypeToContact < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :contact_type, :integer, default: 1
    add_column :contacts, :request_status, :boolean
    add_column :contacts, :schedule_id, :integer
  end
end
