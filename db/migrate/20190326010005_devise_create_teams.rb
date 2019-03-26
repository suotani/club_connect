# frozen_string_literal: true

class DeviseCreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      
      ## basic info
      
      t.string :school  #奈良教育大学
      t.integer :category # 剣道部
      t.string :members # 1年生2人、2年生3人
      t.string :level # 3段2人、初段一人、
      t.string :leader_name
      t.string :leader_email
      t.string :sub_leader_name
      t.string :sub_leader_email
      

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :teams, :email,                unique: true
    add_index :teams, :reset_password_token, unique: true
    add_index :teams, :confirmation_token,   unique: true
    #add_index :teams, :unlock_token,         unique: true
  end
end
