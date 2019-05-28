class Team < ApplicationRecord
  
  attr_accessor :exec_valid
         
  belongs_to :category, optional: true
  belongs_to :leader, class_name: "Member"
  belongs_to :subleader, class_name: "Member", optional: true
  has_many_attached :images
  has_many :calenders
  has_many :contacts
  has_many :member_teams
  has_many :members, through: :member_teams, class_name: "Member"
  
  validates :school, presence: true
  validates :name, presence: true, uniqueness: { scope: :school }
  validates :category_id, presence: true
  
  SCHOOL_TYPE = %w(大学 高校 短期大学)
  INVITE_CODE_LENGTH = 7
  LETTER = ('a'..'z').to_a + (0..9).to_a
  
  def contacts
    Contact.where(from_team_id: id)
    .or(Contact.where(to_team_id: id))
  end
  
  def self.generate_invite_code
    code = ""
    INVITE_CODE_LENGTH.times do
      code = code + LETTER[rand(0..LETTER.size-1)].to_s
    end
    code
  end

end
