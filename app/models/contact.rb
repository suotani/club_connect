class Contact < ApplicationRecord
  has_many :messages
  
  belongs_to :to_team, class_name: "Team"
  belongs_to :from_team, class_name: "Team"
  belongs_to :schedule, optional: true
  
  enum contact_type: {
    request_message: 1,
    normal_message: 2
  }
  
  enum from_team_status: {
    from_team_no_read: 1,
    from_team_read: 2,
    from_team_replyed: 3,
    from_team_send: 4
  }
  
  enum to_team_status: {
    to_team_no_read: 1,
    to_team_read: 2,
    to_team_replyed: 3
  }
  
  TAG = ["", "new", "", "replyed"]
end
