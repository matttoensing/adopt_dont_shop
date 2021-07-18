require 'rails_helper'

RSpec.describe 'admin application show page' do
  it 'admin sees a button to approve each pet on the application' do
    shelter = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
    application = create(:application, status: "Pending")
    pet1 = create(:pet, shelter_id: shelter.id)
    pet2 = create(:pet, shelter_id: shelter.id)
    petapp1 = PetApplication.create!(application_id: application.id, pet_id: pet1.id)
    petapp2 = PetApplication.create!(application_id: application.id, pet_id: pet2.id)

    visit "/admin/applications/#{application.id}"

    expect(page).to have_button("Approve #{pet1.name}")
    expect(page).to have_button("Approve #{pet2.name}")
  end

  it 'when clicking approve button, app status changes from pending to approved and buttons no longer appear' do
    shelter = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
    application = create(:application, status: "Pending")
    pet1 = create(:pet, shelter_id: shelter.id)
    pet2 = create(:pet, shelter_id: shelter.id)
    petapp1 = PetApplication.create!(application_id: application.id, pet_id: pet1.id)
    petapp2 = PetApplication.create!(application_id: application.id, pet_id: pet2.id)

    visit "/admin/applications/#{application.id}"

    click_on "Approve #{pet1.name}"

    expect(current_path).to eq("/admin/applications/#{application.id}")
    expect(page).to_not have_button("Approve #{pet1.name}")
    expect(page).to have_button("Approve #{pet2.name}")
  end
end

#  Approving a Pet for Adoption
#
# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved
