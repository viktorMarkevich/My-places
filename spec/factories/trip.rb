FactoryBot.define do
  factory :trip do
    city Faker::Address.city
    date_from DateTime.now
    date_to DateTime.now + 1.month
  end
end