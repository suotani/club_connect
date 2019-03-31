json.team @team

images = @team.images.map do |image|
    {
        name: image.filename.to_s,
        url: url_for(image),
        id: image.id
    }
end
json.images images

json.categories Category.all

school_types = (Team::SCHOOL_TYPE).map.with_index do |s, index|
  {name: s, id: index}
end
json.school_types school_types

roles = (Team::ROLE).map.with_index do |r, index|
  {name: r, id: index}
end
json.roles roles