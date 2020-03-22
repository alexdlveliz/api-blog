FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.sentence }
    user
    post
  end
end
