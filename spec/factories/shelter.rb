FactoryBot.define do
  factory :shelter do
    name { Faker::Company. }
    street_number  { Faker::Number.between(from: 1, to: 5) }
    street_name { Faker::Address.street_name }
    city { Faker::Address.city }
    state_name { Faker::Address.state }
    zip_code { Faker::Address.zip_code }
    rank Faker::Number.between(from: 1, to: 9)
    foster_program { true }
  end
end
