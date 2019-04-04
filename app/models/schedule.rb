class Schedule < ApplicationRecord
    belongs_to :calender
    has_many :events
    
    
    validates :day, presence: true
    validates :date, presence: true
    
    def to_date_string
      "#{calender.year}年#{calender.month}月#{day}日"
    end
end
