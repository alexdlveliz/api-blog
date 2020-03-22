require "faker"

5.times do |user|
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    auth_token: "xxx"
  )
end

10.times do |post|
  Post.create!(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraph,
    published: true,
    user_id: User.first.id
  )
end

5.times do |comment|
  Comment.create!(
    comment: Faker::Lorem.paragraph,
    user_id: User.first.id,
    post_id: Post.first.id
  )
end