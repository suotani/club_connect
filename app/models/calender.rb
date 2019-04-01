class Calender < ApplicationRecord
    belongs_to :team
    has_many :schedules
end
