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
  end
end
