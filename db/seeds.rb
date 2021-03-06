require "faker"

3.times do |category|
  Category.create!(
    name_category: Faker::Lorem.word
  )
end

3.times do |user|
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "xxxxxx",
    username: Faker::Internet.username
  )
end

3.times do |post|
  Post.create!(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph,
    published: true,
    user_id: User.first.id,
    category_id: Category.first.id
  )
end

3.times do |comment|
  Comment.create!(
    content: Faker::Lorem.paragraph,
    user_id: User.first.id,
    post_id: Post.first.id
  )
end