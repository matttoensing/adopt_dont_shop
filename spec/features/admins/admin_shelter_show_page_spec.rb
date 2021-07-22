require 'rails_helper'

RSpec.describe 'admin shelter show page' do
  describe 'page statistics' do
    it 'has a section for statistics which includes the average age of pets' do
      shelter = Shelter.create!(name: 'Boulder Valley Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      pet1 = create(:pet, age: 3, shelter_id: shelter.id)
      pet2 = create(:pet, age: 2, shelter_id: shelter.id)
      pet3 = create(:pet, age: 3, shelter_id: shelter.id)
      pet4 = create(:pet, age: 4, shelter_id: shelter.id)

      visit "/admin/shelters/#{shelter.id}"

      expect(page).to have_content("Statistics")
      expect(page).to have_content(shelter.pet_count)
      expect(page).to have_content(shelter.average_pet_age)
      expect(page).to have_content(shelter.adoptable_pets_count)
    end

    it 'has a section for number of pets that have been adopted from the shelter' do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      application1 = create(:application, status: "Approved")
      application2 = create(:application, status: "Approved")
      application3 = create(:application, status: "Approved")
      application4 = create(:application, status: "Approved")
      application5 = create(:application, status: "Approved")
      pet1 = create(:pet, shelter_id: shelter.id)
      pet2 = create(:pet, shelter_id: shelter.id)
      pet3 = create(:pet, shelter_id: shelter.id)
      pet4 = create(:pet, shelter_id: shelter.id)
      pet5 = create(:pet, shelter_id: shelter.id)
      pet6 = create(:pet, shelter_id: shelter.id)
      pet7 = create(:pet, shelter_id: shelter.id)
      pet8 = create(:pet, shelter_id: shelter.id)
      pet9 = create(:pet, shelter_id: shelter.id)
      petapp1 = PetApplication.create!(application_id: application1.id, pet_id: pet1.id, status: "Approved")
      petapp2 = PetApplication.create!(application_id: application1.id, pet_id: pet5.id, status: "Approved")
      petapp3 = PetApplication.create!(application_id: application1.id, pet_id: pet7.id, status: "Approved")
      petapp4 = PetApplication.create!(application_id: application2.id, pet_id: pet8.id, status: "Approved")
      petapp5 = PetApplication.create!(application_id: application2.id, pet_id: pet3.id, status: "Approved")
      petapp6 = PetApplication.create!(application_id: application2.id, pet_id: pet9.id, status: "Approved")
      petapp7 = PetApplication.create!(application_id: application3.id, pet_id: pet2.id, status: "Approved")
      petapp8 = PetApplication.create!(application_id: application3.id, pet_id: pet6.id, status: "Approved")
      petapp9 = PetApplication.create!(application_id: application3.id, pet_id: pet4.id, status: "Approved")

      visit "/admin/shelters/#{shelter.id}"

      expect(page).to have_content(Shelter.number_of_adoptions(shelter.id))
    end
  end

  describe 'action needed' do
    it 'has a section on the page that shows each shelters pet that has a pending application' do
      shelter = Shelter.create!(name: 'Boulder Valley Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      application1 = create(:application, status: "Pending")
      application2 = create(:application, status: "Pending")
      application3 = create(:application, status: "Approved")
      pet1 = create(:pet, shelter_id: shelter.id)
      pet2 = create(:pet, shelter_id: shelter.id)
      pet3 = create(:pet, shelter_id: shelter.id)
      pet4 = create(:pet, shelter_id: shelter.id)
      pet5 = create(:pet, shelter_id: shelter.id)
      petapp1 = PetApplication.create!(application_id: application1.id, pet_id: pet1.id, status: "Pending")
      petapp2 = PetApplication.create!(application_id: application1.id, pet_id: pet2.id, status: "Pending")
      petapp3 = PetApplication.create!(application_id: application2.id, pet_id: pet3.id, status: "Pending")
      petapp4 = PetApplication.create!(application_id: application3.id, pet_id: pet4.id, status: "Approved")

      visit "/admin/shelters/#{shelter.id}"

      expect(page).to have_content("Action Required")
      expect(page).to have_content("Pending #{pet1.name}")
      expect(page).to have_content("Pending #{pet2.name}")
      expect(page).to have_content("Pending #{pet3.name}")
    end

    it 'has a link to the admin application show page next to each pets name' do
      shelter = Shelter.create!(name: 'Boulder Valley Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      application1 = create(:application, status: "Pending")
      application2 = create(:application, status: "Pending")
      application3 = create(:application, status: "Approved")
      pet1 = create(:pet, shelter_id: shelter.id)
      pet2 = create(:pet, shelter_id: shelter.id)
      pet3 = create(:pet, shelter_id: shelter.id)
      pet4 = create(:pet, shelter_id: shelter.id)
      pet5 = create(:pet, shelter_id: shelter.id)
      petapp1 = PetApplication.create!(application_id: application1.id, pet_id: pet1.id, status: "Pending")
      petapp2 = PetApplication.create!(application_id: application1.id, pet_id: pet2.id, status: "Pending")
      petapp3 = PetApplication.create!(application_id: application2.id, pet_id: pet3.id, status: "Pending")
      petapp4 = PetApplication.create!(application_id: application3.id, pet_id: pet4.id, status: "Approved")

      visit "/admin/shelters/#{shelter.id}"

      expect(page).to have_content("Pending Applications: #{application1.name}")
      expect(page).to have_content("Pending Applications: #{application2.name}")
      expect(page).to have_link(application1.name)
      expect(page).to have_link(application2.name)
    end
  end

  describe 'shelter address' do
    it 'the full address is listed on the shelter page' do
      shelter = create(:shelter, street_number: "1234", street_name: "Main St.", city: "Boulder", state_name: "CO", zip_code: "81230")

      visit "/admin/shelters/#{shelter.id}"

      expect(page).to have_content(Shelter.full_address(shelter.id))
    end
  end
end
