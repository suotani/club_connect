class AddColumnTeamIdToCalender < ActiveRecord::Migration[5.2]
  def change
    add_column :calenders, :team_id, :integer
  end
end
