FactoryBot.define do
  factory :application do
    name { Faker::Name.name }
    street  { Faker::Address.street_name  }
    city  { Faker::Address.city }
    state  { Faker::Address.state }
    zip_code  { Faker::Address.zip_code }
    description  { Faker::Lorem.paragraphs(rand(2..8)) }
    status { "In Progress" }
  end
end
