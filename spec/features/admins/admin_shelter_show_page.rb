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
      expect(page).to have("Number of Pets: #{shelter.pet_count}")
      expect(page).to have("Average Pet Age: #{shelter.average_pet_age}")
      expect(page).to have("Number of Adoptable Pets: #{shelter.adoptable_pets}")
    end
  end
end
