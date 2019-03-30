class CreateCalenders < ActiveRecord::Migration[5.2]
  def change
    create_table :calenders do |t|
      t.integer :year
      t.integer :month

      t.timestamps
    end
  end
end
