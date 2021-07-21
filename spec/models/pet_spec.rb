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

    describe '#pending_applications' do
      it 'can find pets with pending pet applications' do
        shelter = Shelter.create(name: 'Voulder Valley Shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        application1 = create(:application, status: "Pending")
        application2 = create(:application, status: "Pending")
        application3 = create(:application, status: "Approved")
        pet1 = create(:pet, shelter_id: shelter.id)
        pet2 = create(:pet, shelter_id: shelter.id)
        pet3 = create(:pet, shelter_id: shelter.id)
        petapp1 = PetApplication.create!(pet_id: pet1.id, application_id: application1.id, status: "Pending")
        petapp2 = PetApplication.create!(pet_id: pet2.id, application_id: application2.id, status: "Pending")
        petapp3 = PetApplication.create!(pet_id: pet3.id, application_id: application3.id, status: "Approved")

        expected = [pet1, pet2]

        expect(Pet.pending_applications).to eq(expected)
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
