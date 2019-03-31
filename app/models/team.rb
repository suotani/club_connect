class Team < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
  belongs_to :category
  has_many_attached :images
  
  ROLE = %w(部長 マネージャ 副部長 顧問教員 外部顧問 その他)
  SCHOOL_TYPE = %w(大学 高校 短期大学)
end
