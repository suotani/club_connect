json.categories Category.all
json.teams do
  json.array! @teams do |team|
    json.id team.id
    json.school team.school
    json.category team.category.name
    json.leader_name team.leader.name
  end
end
school_types = (Team::SCHOOL_TYPE).map.with_index do |s, index|
  {name: s, id: index}
end
json.school_types school_types
json.total_team_count @total_team_count