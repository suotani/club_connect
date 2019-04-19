class AddColumnGradeToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :grade, :integer, default: 1
    add_column :members, :profile, :string
  end
end
