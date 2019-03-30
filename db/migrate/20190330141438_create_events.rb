class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :schedule_id
      t.string :text
      t.integer :team_id

      t.timestamps
    end
  end
end
