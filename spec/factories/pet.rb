FactoryBot.define do
  factory :pet do
    name { Faker::Creature::Dog.name }
    breed  { Faker::Creature::Dog.breed }
    adoptable { true }
    age { 4 }
  end
end
