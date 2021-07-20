require 'rails_helper'

RSpec.describe 'admins visiting shelter page' do
  describe 'order of shelters shown' do
    it 'when admin visits shelter page, it shows all shelters in reverse alphabetical order' do
      shelter1 = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      shelter2 = Shelter.create!(name: 'Boulder Valley shelter', city: 'Boulder, CO', foster_program: true, rank: 9)
      shelter3 = Shelter.create!(name: 'Westminster Area shelter', city: 'Westminster, CO', foster_program: true, rank: 6)
      shelter4 = Shelter.create!(name: 'Denver City shelter', city: 'Denver, CO', foster_program: true, rank: 8)

      visit '/admin/shelters'

      expect(shelter3.name).to appear_before(shelter4.name)
      expect(shelter4.name).to appear_before(shelter2.name)
      expect(shelter2.name).to appear_before(shelter1.name)
    end
  end

  describe 'page has page below all shelters' do
    it 'shows all shelters with pending applications' do
      shelter1 = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      shelter2 = Shelter.create!(name: 'Boulder Valley shelter', city: 'Boulder, CO', foster_program: true, rank: 9)
      shelter3 = Shelter.create!(name: 'Westminster Area shelter', city: 'Westminster, CO', foster_program: true, rank: 6)
      shelter4 = Shelter.create!(name: 'Denver City shelter', city: 'Denver, CO', foster_program: true, rank: 8)
      application1 = create(:application, status: "Pending")
      application2 = create(:application)
      application3 = create(:application, status: "Pending")
      application4 = create(:application, status: "Pending")
      application5 = create(:application)
      application6 = create(:application)
      pet1 = create(:pet, shelter_id: shelter1.id)
      pet2 = create(:pet, shelter_id: shelter2.id)
      pet3 = create(:pet, shelter_id: shelter2.id)
      petapp1 = PetApplication.create!(application_id: application1.id, pet_id: pet1.id)
      petapp2 = PetApplication.create!(application_id: application3.id, pet_id: pet2.id)
      petapp3 = PetApplication.create!(application_id: application4.id, pet_id: pet3.id)

      visit '/admin/shelters'

      expect(page).to have_content("Shelter's with Pending Applications")
      expect("Shelter's with Pending Applications").to appear_before("Shelter: #{shelter1.name}")
      expect("Shelter's with Pending Applications").to appear_before("Shelter: #{shelter2.name}")
    end

    it 'the shelters are listed in alphabetical order' do
      shelter1 = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      shelter2 = Shelter.create!(name: 'Boulder Valley shelter', city: 'Boulder, CO', foster_program: true, rank: 9)
      shelter3 = Shelter.create!(name: 'Westminster Area shelter', city: 'Westminster, CO', foster_program: true, rank: 6)
      shelter4 = Shelter.create!(name: 'Denver City shelter', city: 'Denver, CO', foster_program: true, rank: 8)
      application1 = create(:application, status: "Pending")
      application2 = create(:application)
      application3 = create(:application, status: "Pending")
      application4 = create(:application, status: "Pending")
      application5 = create(:application)
      application6 = create(:application, status: "Pending")
      pet1 = create(:pet, shelter_id: shelter1.id)
      pet2 = create(:pet, shelter_id: shelter2.id)
      pet3 = create(:pet, shelter_id: shelter2.id)
      pet4 = create(:pet, shelter_id: shelter3.id)
      petapp1 = PetApplication.create!(application_id: application1.id, pet_id: pet1.id)
      petapp2 = PetApplication.create!(application_id: application3.id, pet_id: pet2.id)
      petapp3 = PetApplication.create!(application_id: application4.id, pet_id: pet3.id)
      petapp4 = PetApplication.create!(application_id: application6.id, pet_id: pet4.id)

      visit '/admin/shelters'

      expect("Shelter: #{shelter1.name}").to appear_before("Shelter: #{shelter2.name}")
      expect("Shelter: #{shelter2.name}").to appear_before("Shelter: #{shelter3.name}")
    end
  end
end
