FactoryBot.define do
  factory :application do
    name { Faker::Name.name }
    street  { Faker::Address.street_name  }
    city  { Faker::Address.city }
    state  { Faker::Address.state }
    zip_code  { Faker::Address.zip_code }
    description  { Faker::Quote.most_interesting_man_in_the_world }
    status { "In Progress" }
  end
end
