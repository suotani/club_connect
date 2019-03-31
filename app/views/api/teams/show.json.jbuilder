json.set! :team do
  json.school  @team.school
  json.category  @team.category.name
  json.members  @team.members
  json.introduction  @team.introduction
  json.leader_email  @team.leader_email
  json.leader_name  @team.leader_name
  json.leader_role  @team.leader_role
  json.sub_leader_name  @team.sub_leader_name
  json.sub_leader_email  @team.sub_leader_email
  json.sub_leader_role  @team.sub_leader_role
end