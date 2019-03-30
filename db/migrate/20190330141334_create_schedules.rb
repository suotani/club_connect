class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.integer :calender_id
      t.integer :day
      t.integer :request

      t.timestamps
    end
  end
end
