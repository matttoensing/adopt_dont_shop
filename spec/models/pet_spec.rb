require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it { should have_many(:pet_applications)}
    it { should have_many(:applications).through(:pet_applications)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
    it { should validate_presence_of(:breed) }
    # it { should validate_presence_of(:adoptable) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        Pet.destroy_all
        pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
        pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
        expect(Pet.adoptable).to eq([pet_1, pet_2])
      end
    end

    describe '#find_by_search_name' do
      it 'returns pets with a given name ' do
        expect(Pet.find_by_search_name('Ann')).to eq([@pet_3])
        expect(Pet.find_by_search_name('Clawdia')).to eq([@pet_2])
      end

      it 'can return a pet with a partial lower case name' do
        expect(Pet.find_by_search_name('pira')).to eq([@pet_1])
        expect(Pet.find_by_search_name('claw')).to eq([@pet_2])
      end
    end

    describe '#approve_pets' do
      it 'it will find all pets that have not been aproved on application' do
        expected = [@pet_3, @pet_2]
        expect(Pet.approve_pets(@pet_1.id)).to eq(expected)

        expected2 = [@pet_1, @pet_2]
        expect(Pet.approve_pets(@pet_3.id)).to eq(expected2)
      end
    end

    describe '#find_by_application_id' do
      it 'can find a pet with a given application id' do
        shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
        shelter2 = Shelter.create!(name: 'Westminster shelter', city: 'Westminster, CO', foster_program: true, rank: 7)
        application1 = create(:application, status: "Pending")
        application2 = create(:application, status: "Pending")
        application3 = create(:application, status: "Pending")
        pet1 = create(:pet, shelter_id: shelter1.id)
        pet2 = create(:pet, shelter_id: shelter2.id)
        pet3 = create(:pet, shelter_id: shelter2.id)
        petapp1 = PetApplication.create!(application_id: application1.id, pet_id: pet1.id)
        petapp2 = PetApplication.create!(application_id: application1.id, pet_id: pet2.id)
        petapp3 = PetApplication.create!(application_id: application3.id, pet_id: pet3.id)

        expected = [pet1]

        expect(Pet.find_by_application_id(application1.id)).to eq(expected)

        expected2 = [pet3]

        expect(Pet.find_by_application_id(application3.id)).to eq(expected2)
      end
    end
  end

  describe 'instance methods' do
    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end
  end
end
