json.categories Category.all

school_types = (Team::SCHOOL_TYPE).map.with_index do |s, index|
  {name: s, id: index}
end
json.school_types school_types