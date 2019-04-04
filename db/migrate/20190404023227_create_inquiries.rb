class CreateInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiries do |t|
      t.string :email
      t.text :text
      t.integer :status
      t.integer :team_id

      t.timestamps
    end
  end
end
