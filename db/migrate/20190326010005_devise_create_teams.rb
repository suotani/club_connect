# frozen_string_literal: true

class DeviseCreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :school  #奈良教育大学
      t.integer :category # 剣道部
      t.string :members_info # 1年生2人、2年生3人
      t.string :level # 3段2人、初段一人
      t.string :prefecture #都道府県
      t.string :city # 市
      t.string :address # 以降の住所
      t.integer :leader_id
      t.integer :subleader_id

      t.timestamps null: false
    end
  end
end
