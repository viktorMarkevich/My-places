FactoryBot.define do
  factory :user do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    sequence  :email do |n|
      "person#{n}@example.com"
    end
    password '123456'
    password_confirmation '123456'
  end
end