namespace :trip do
  desc 'create 10 trips'
  task generate_trips: :environment do
    10.times do
      Trip.create(city: Faker::Address.city)
    end
  end
end