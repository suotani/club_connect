class AddDefaultRoleIdToMember < ActiveRecord::Migration[5.2]
  def change
    change_column :members, :role_id, :integer, null: true
  end
end
