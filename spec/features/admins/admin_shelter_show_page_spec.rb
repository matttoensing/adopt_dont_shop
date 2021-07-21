require 'rails_helper'

RSpec.describe 'admin shelter show page' do
  describe 'links on page' do
    it 'displays names on the page as links' do
      shelter1 = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      shelter2 = Shelter.create!(name: 'Westminster Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      shelter3 = Shelter.create!(name: 'Boulder Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)

      visit '/admin/shelters'

      expect(page).to have_link("#{shelter1.name}")
      expect(page).to have_link("#{shelter2.name}")
      expect(page).to have_link("#{shelter3.name}")
    end

    it 'when clicking on the shelter name, you are taken to the admin shelter show page' do
      shelter1 = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      shelter2 = Shelter.create!(name: 'Westminster Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      shelter3 = Shelter.create!(name: 'Boulder Valley Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)

      visit '/admin/shelters'
      click_on "#{shelter3.name}"

      expect(current_path).to eq("/admin/shelters/#{shelter3.id}")
      expect(page).to have_content('Boulder Valley Shelter')
    end
  end

  describe 'page statistics' do
    it 'has a section for statistics which includes the average age of pets' do
      shelter = Shelter.create!(name: 'Boulder Valley Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      pet1 = create(:pet, age: 3, shelter_id: shelter.id)
      pet2 = create(:pet, age: 2, shelter_id: shelter.id)
      pet3 = create(:pet, age: 3, shelter_id: shelter.id)
      pet4 = create(:pet, age: 4, shelter_id: shelter.id)

      visit "/admin/shelters/#{shelter.id}"

      expect(page).to have_content("Statistics")
      expect(page).to have_content("Number of Pets: #{shelter.pet_count}")
      expect(page).to have_content("Average Pet Age: #{shelter.average_pet_age}")
      expect(page).to have_content("Number of Adoptable Pets: #{shelter.adoptable_pets}")
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

      expect(page).to have_content("Number of Pets Adopted: #{Shelter.number_of_adoptions(shelter.id)}")
    end
  end
end
