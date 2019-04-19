class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  has_many :member_teams
  has_many :teams, through: :member_teams, class_name: "Team"
  
  belongs_to :team, optional: true
  
  has_one_attached :avatar
  
  ROLE = %w(部長 マネージャ 副部長 顧問教員 外部顧問 その他)
end
