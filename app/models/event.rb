class Event < ApplicationRecord
    belongs_to :schedule
    belongs_to :team, optional: true
end
