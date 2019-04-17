class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :member_teams
  has_many :teams, through: :member_teams, class_name: "Team"
  
  belongs_to :team, optional: true
end
