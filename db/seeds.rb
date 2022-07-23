# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者用のコード
Admin.create!(
   email: 'stray@cat',
   password: 'mayoineko'
)

users = User.create!(
 [
    {email: 'test1@test.com', name: 'ねこねこ', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg", is_deleted: false)},
    {email: 'test2@test.com', name: 'ノラ', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg", is_deleted: false)},
    {email: 'test3@test.com', name: 'マヨネコ', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg", is_deleted: false)}
 ]
)

Post.create!(
 [
    {title: '野良猫がいました！', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"), introduction: '黒と白の猫がいました！', user_id: users[0].id, genre_id: genres[0].id },
    {title: '前回と同じ猫！', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg"), introduction: 'この前と同じ猫がいました〜', user_id: users[1].id, genre_id: genres[0].id },
    {title: '空き地に猫がいた', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"), introduction: '空き地に野良猫がいたよ', user_id: users[2].id, genre_id: genres[0].id }
 ]
)

Genre.create!(
   [
    {genre:野良猫},
    {genre:迷い猫}
 ]
   )