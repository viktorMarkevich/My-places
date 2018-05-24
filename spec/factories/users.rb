FactoryBot.define do
  factory :user do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    sequence  :email do |n|
      "person#{n}@example.com"
    end
    confirmation_sent_at Time.now.utc
    confirmation_token 'confirmation_token'
    password '123456'
    password_confirmation '123456'
  end
end