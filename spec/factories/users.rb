FactoryBot.define do
  factory :user do
    first_name { Faker::Lorem.name }
    last_name { Faker::Lorem.name }
    email sequence{|n| 'email@example.com' + n }
    password '123456'
    password_confirmation '123456'
  end
end