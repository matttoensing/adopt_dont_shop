require 'rails_helper'

RSpec.describe 'admins visiting shelter page' do
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
