FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence  :email do |n|
      "person#{n}@example.com"
    end
    password '123456'
    password_confirmation '123456'
  end

  factory :user_with_token, parent: :user do
    token 'sdfasdgujsdf'
  end
end