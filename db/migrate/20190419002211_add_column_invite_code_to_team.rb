class AddColumnInviteCodeToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :invite_code, :string
  end
end
