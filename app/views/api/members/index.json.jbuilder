json.members do
  json.array! @members do |m|
    json.id           m.id
    json.name         m.name
    json.email        m.email
    json.grade        m.grade
    json.role_in_team m.role_in_team
    json.avatar_url   url_for(m.avatar) if m.avatar.attached?
    json.profile      (m.profile || "")[0..50]
    json.longProfile      (m.profile || "")
  end
end