class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :name
      t.boolean :member_edit
      t.boolean :contact
      t.boolean :schedule
      t.boolean :login

      t.timestamps
    end
  end
end
