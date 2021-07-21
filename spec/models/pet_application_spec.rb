require 'rails_helper'

RSpec.describe PetApplication do
  describe 'relationships' do
    it { should belong_to(:application)}
    it { should belong_to(:pet)}
  end

  describe 'class methods' do
    describe '#find_with_ids' do
      it 'can find a pet application with an application id and pet id' do
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

        expect(PetApplication.find_with_ids(application4.id, pet1.id)).to eq(petapp4)
        expect(PetApplication.find_with_ids(application4.id, pet3.id)).to eq(petapp3)
      end
    end
  end
end
