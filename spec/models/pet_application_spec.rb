require 'rails_helper'

RSpec.describe PetApplication do
  describe 'relationships' do
    it { should belong_to(:application)}
    it { should belong_to(:pet)}
  end

  #Don;t need method, can delete this test
  describe 'class methods' do
    describe '#find_by_application_id' do
      xit 'can find a pet application with a given application id' do
      shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      shelter2 = Shelter.create!(name: 'Westminster shelter', city: 'Westminster, CO', foster_program: true, rank: 7)
      application1 = create(:application, status: "Pending")
      application2 = create(:application, status: "Pending")
      application3 = create(:application, status: "Pending")
      pet1 = create(:pet, shelter_id: shelter1.id)
      pet2 = create(:pet, shelter_id: shelter2.id)
      pet3 = create(:pet, shelter_id: shelter2.id)
      petapp1 = PetApplication.create!(application_id: application1.id, pet_id: pet1.id)
      petapp2 = PetApplication.create!(application_id: application2.id, pet_id: pet2.id)
      petapp3 = PetApplication.create!(application_id: application3.id, pet_id: pet3.id)

      expected = petapp3

      expect(PetApplication.find_by_application_id(application3.id)).to eq(expected)
    end
  end
end
end
