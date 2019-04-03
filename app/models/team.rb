class Team < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
  belongs_to :category
  has_many_attached :images
  has_many :calenders
  has_many :contacts
  
  ROLE = %w(部長 マネージャ 副部長 顧問教員 外部顧問 その他)
  SCHOOL_TYPE = %w(大学 高校 短期大学)
  
  def contacts
    Contact.where(from_team_id: id)
    .or(Contact.where(to_team_id: id))
  end
end
