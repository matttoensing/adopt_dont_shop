require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many(:pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:rank) }
    it { should validate_numericality_of(:rank) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Shelter.search("Fancy")).to eq([@shelter_3])
      end
    end

    describe '#order_by_recently_created' do
      it 'returns shelters with the most recently created first' do
        expect(Shelter.order_by_recently_created).to eq([@shelter_3, @shelter_2, @shelter_1])
      end
    end

    describe '#order_by_number_of_pets' do
      it 'orders the shelters by number of pets they have, descending' do
        expect(Shelter.order_by_number_of_pets).to eq([@shelter_1, @shelter_3, @shelter_2])
      end
    end

    describe '#order_in_reverse' do
      it 'orders the shelters in reverse alphabetical order' do
        Shelter.destroy_all

        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

        expected = [shelter_2, shelter_3, shelter_1]

        expect(Shelter.order_in_reverse).to eq(expected)
      end
    end

    describe '#shelters_with_pending_apps' do
      it 'returns all shelters with pending applications' do
        Shelter.destroy_all

        shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
        shelter2 = Shelter.create!(name: 'Westminster shelter', city: 'Westminster, CO', foster_program: true, rank: 7)
        shelter3 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: true, rank: 9)
        application1 = create(:application, status: "Pending")
        application2 = create(:application)
        application3 = create(:application, status: "Pending")
        application4 = create(:application, status: "Pending")
        application5 = create(:application, status: "Approved")
        application6 = create(:application)
        pet1 = create(:pet, shelter_id: shelter1.id)
        pet2 = create(:pet, shelter_id: shelter2.id)
        pet3 = create(:pet, shelter_id: shelter2.id)
        petapp1 = PetApplication.create!(application_id: application1.id, pet_id: pet1.id, status: "Pending")
        petapp2 = PetApplication.create!(application_id: application3.id, pet_id: pet2.id, status: "Pending")
        petapp3 = PetApplication.create!(application_id: application4.id, pet_id: pet3.id, status: "Pending")
        petapp4 = PetApplication.create!(application_id: application4.id, pet_id: pet1.id, status: "Approved")

        expected = [shelter1, shelter2]

        expect(Shelter.shelters_with_pending_apps).to eq(expected)
      end
    end

    describe '#number_of_adoptions' do
      it 'returns number of pets that have been adopted from a given shelter' do
        Shelter.destroy_all

        shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
        shelter2 = Shelter.create!(name: 'Westminster shelter', city: 'Westminster, CO', foster_program: true, rank: 7)
        shelter3 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: true, rank: 9)
        application1 = create(:application, status: "Approved")
        application2 = create(:application, status: "Approved")
        application3 = create(:application, status: "Approved")
        application4 = create(:application, status: "Approved")
        application5 = create(:application, status: "Approved")
        pet1 = create(:pet, shelter_id: shelter1.id)
        pet2 = create(:pet, shelter_id: shelter1.id)
        pet3 = create(:pet, shelter_id: shelter1.id)
        pet4 = create(:pet, shelter_id: shelter1.id)
        pet5 = create(:pet, shelter_id: shelter2.id)
        pet6 = create(:pet, shelter_id: shelter2.id)
        pet7 = create(:pet, shelter_id: shelter2.id)
        pet8 = create(:pet, shelter_id: shelter3.id)
        pet9 = create(:pet, shelter_id: shelter3.id)
        petapp1 = PetApplication.create!(application_id: application1.id, pet_id: pet1.id, status: "Approved")
        petapp2 = PetApplication.create!(application_id: application1.id, pet_id: pet5.id, status: "Approved")
        petapp3 = PetApplication.create!(application_id: application1.id, pet_id: pet7.id, status: "Approved")
        petapp4 = PetApplication.create!(application_id: application2.id, pet_id: pet8.id, status: "Approved")
        petapp5 = PetApplication.create!(application_id: application2.id, pet_id: pet3.id, status: "Approved")
        petapp6 = PetApplication.create!(application_id: application2.id, pet_id: pet9.id, status: "Approved")
        petapp7 = PetApplication.create!(application_id: application3.id, pet_id: pet2.id, status: "Approved")
        petapp8 = PetApplication.create!(application_id: application3.id, pet_id: pet6.id, status: "Approved")
        petapp9 = PetApplication.create!(application_id: application3.id, pet_id: pet4.id, status: "Approved")
        petapp10 = PetApplication.create!(application_id: application5.id, pet_id: pet6.id, status: "Pending")
        petapp11 = PetApplication.create!(application_id: application5.id, pet_id: pet4.id, status: "Pending")

        expect(Shelter.number_of_adoptions(shelter1.id)).to eq(4)
        expect(Shelter.number_of_adoptions(shelter2.id)).to eq(3)
        expect(Shelter.number_of_adoptions(shelter3.id)).to eq(2)
      end
    end

    describe '#order_by_name' do
      it 'returns shelters in ascending alphabetical order' do
        Shelter.destroy_all

        shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
        shelter2 = Shelter.create!(name: 'Westminster shelter', city: 'Westminster, CO', foster_program: true, rank: 7)
        shelter3 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: true, rank: 9)

        expected = [shelter1, shelter3, shelter2]

        expect(Shelter.order_by_name).to eq(expected)
      end
    end
  end

  describe 'instance methods' do
    describe '.adoptable_pets' do
      it 'only returns pets that are adoptable' do
        expect(@shelter_1.adoptable_pets).to eq([@pet_2, @pet_4])
      end
    end

    describe '.adoptable_pets_count' do
      it 'only returns pets that are adoptable' do
        expect(@shelter_1.adoptable_pets_count).to eq(2)
      end
    end

    describe '.alphabetical_pets' do
      it 'returns pets associated with the given shelter in alphabetical name order' do
        expect(@shelter_1.alphabetical_pets).to eq([@pet_4, @pet_2])
      end
    end

    describe '.shelter_pets_filtered_by_age' do
      it 'filters the shelter pets based on given params' do
        expect(@shelter_1.shelter_pets_filtered_by_age(5)).to eq([@pet_4])
      end
    end

    describe '.pet_count' do
      it 'returns the number of pets at the given shelter' do
        expect(@shelter_1.pet_count).to eq(3)
      end
    end

    describe '#average_pet_age' do
      it 'returns the average age of all pets belonging to a shelter' do
        shelter = Shelter.create!(name: 'Boulder Valley Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
        pet1 = create(:pet, age: 3, shelter_id: shelter.id)
        pet2 = create(:pet, age: 2, shelter_id: shelter.id)
        pet3 = create(:pet, age: 3, shelter_id: shelter.id)
        pet4 = create(:pet, age: 4, shelter_id: shelter.id)

        expect(shelter.average_pet_age).to eq(3)
      end
    end
  end
end
