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

41.times do |i|
    label_id = rand(Team::SCHOOL_TYPE.count)
    label = Team::SCHOOL_TYPE[label_id]
    t = Team.create(
        email: Faker::Internet.email,
        password: "111111",
        school: Faker::Name.name + label,
        school_type: label_id,
        category_id: rand(1..category_count),
        members: "1年生3名\n2年生7名\n3年生8名\nマネージャー2名",
        introduction: "和気あいあいと楽しくやっています。\n練習相手を募集しています。",
        leader_name: Faker::Name.name,
        leader_email: Faker::Internet.email,
        leader_role: Team::ROLE[rand(0..4)],
        sub_leader_name: Faker::Name.name,
        sub_leader_email: Faker::Internet.email,
        sub_leader_role: Team::ROLE[rand(0..4)]
    )
    t.confirm
end