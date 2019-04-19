json.set! :team do
  json.school      @team.school
  json.name        @team.name
  json.leader_name @team.leader.name
  json.id          @team.id
end