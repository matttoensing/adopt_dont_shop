require 'rails_helper'

RSpec.describe 'admin shelter index page' do
  describe 'links on page' do
    it 'displays names on the page as links' do
      shelter1 = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      shelter2 = Shelter.create!(name: 'Westminster Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
      shelter3 = Shelter.create!(name: 'Boulder Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)

      visit '/admin/shelters'

      within "#shelter-#{shelter1.id}" do
        expect(page).to have_content(shelter1.city)
        expect(page).to have_link("#{shelter1.name}")
      end

      within "#shelter-#{shelter2.id}" do
        expect(page).to have_content(shelter1.city)
        expect(page).to have_link("#{shelter1.name}")
      end

      within "#shelter-#{shelter3.id}" do
        expect(page).to have_content(shelter3.city)
        expect(page).to have_link("#{shelter3.name}")
      end
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
end
