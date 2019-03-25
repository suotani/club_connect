class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :text
      t.integer :status, default: 1
      t.datetime :limit_at

      t.timestamps
    end
  end
end
