class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :contact_id
      t.text :text
      t.string :from_team

      t.timestamps
    end
  end
end
