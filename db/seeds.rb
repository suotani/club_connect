# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Faker::Config.locale = :ja

%w(テニス ソフトテニス 野球 軟式野球 サッカー アメリカンフットボール ラグビー ボクシング 茶道 書道 華道 コンピュータ).each do |i|
    Category.create(name: i)
end

category_count = Category.count

manager = Role.create(name: "Manager", member_edit: true, contact: true, schedule: true, login: true)
writer = Role.create(name: "Writer", member_edit: false, contact: false, schedule: true, login: true)
reader = Role.create(name: "Reader", member_edit: false, contact: false, schedule: false, login: true)
reject = Role.create(name: "Reject", member_edit: true, contact: true, schedule: true, login: true)

3.times do |i|
    members = Role.all.map do |r|
      m = Member.new(
        name: Faker::Name.name,
        role_id: r.id,
        email: Faker::Internet.email,
        password: "111111",
        confirmed_at: DateTime.now
      )
      m.skip_confirmation!
      m.save
    end
    t = Team.create(
        school: Faker::Name.name + Team::SCHOOL_TYPE[rand(Team::SCHOOL_TYPE.count)],
        school_type: label_id,
        category_id: rand(1..category_count),
        members: "1年生3名\n2年生7名\n3年生8名\nマネージャー2名",
        introduction: "和気あいあいと楽しくやっています。\n練習相手を募集しています。",
        leader_id: members[0].id
        subleader_id: members[1].id
    )
    members.each do |m|
      MemberTeam.create(member_id: m.id, team_id: t.id)
    end
end