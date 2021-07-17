FactoryBot.define do
  factory :pet do
    name { Faker::Creature::Dog.name }
    breed  { Faker::Creature::Dog.breed }
    adoptable { true }
    age { Faker::Number.between(from: 1, to: 13) }
  end
end
