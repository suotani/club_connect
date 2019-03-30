class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.integer :from_team_id
      t.integer :from_team_status
      t.integer :to_team_id
      t.integer :to_team_status
      t.string :title

      t.timestamps
    end
  end
end
