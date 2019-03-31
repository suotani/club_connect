class AddColumnIntroductionToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :introduction, :text
    add_column :teams, :category_id, :integer
    add_column :teams, :leader_role, :string
    add_column :teams, :sub_leader_role, :string
    add_column :teams, :school_type, :integer
    
    remove_column :teams, :category, :integer
  end
end
