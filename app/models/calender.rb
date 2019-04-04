class Calender < ApplicationRecord
    belongs_to :team
    has_many :schedules
    
    validates :year, presence: true
    validates :month, presence: true
end
