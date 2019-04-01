class Schedule < ApplicationRecord
    belongs_to :calender
    has_many :events
end
