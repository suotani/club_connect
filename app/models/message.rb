class Message < ApplicationRecord
    belongs_to :contact
    
    validates :text, presence: true
end
