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

  it 'has a reject button next to each pet before approval' do
    shelter = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
    application = create(:application, status: "Pending")
    pet1 = create(:pet, shelter_id: shelter.id)
    pet2 = create(:pet, shelter_id: shelter.id)
    petapp1 = PetApplication.create!(application_id: application.id, pet_id: pet1.id)
    petapp2 = PetApplication.create!(application_id: application.id, pet_id: pet2.id)

    visit "/admin/applications/#{application.id}"

    expect(page).to have_button("Reject #{pet1.name} Adoption Request")
    expect(page).to have_button("Reject #{pet2.name} Adoption Request")
  end

  it 'when clicking reject button, the buttons disappear and the status shows rejection' do
    shelter = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
    application = create(:application, status: "Pending")
    pet1 = create(:pet, shelter_id: shelter.id)
    pet2 = create(:pet, shelter_id: shelter.id)
    petapp1 = PetApplication.create!(application_id: application.id, pet_id: pet1.id)
    petapp2 = PetApplication.create!(application_id: application.id, pet_id: pet2.id)

    visit "/admin/applications/#{application.id}"

    click_on "Reject #{pet1.name} Adoption Request"

    expect(page).to_not have_button("Reject #{pet1.name} Adoption Request")
    expect(page).to have_content("Status: Rejected")
    expect(page).to have_content("#{pet1.name} Rejected")
  end

  it 'clicking reject on one application does not affect other applications for the same pet' do
    shelter = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
    application1 = create(:application, status: "Pending")
    application2 = create(:application, status: "Pending")
    application3 = create(:application, status: "Pending")
    pet1 = create(:pet, shelter_id: shelter.id)
    pet2 = create(:pet, shelter_id: shelter.id)
    petapp1 = PetApplication.create!(application_id: application1.id, pet_id: pet1.id)
    petapp2 = PetApplication.create!(application_id: application1.id, pet_id: pet2.id)
    petapp3 = PetApplication.create!(application_id: application2.id, pet_id: pet1.id)
    petapp4 = PetApplication.create!(application_id: application3.id, pet_id: pet2.id)

    visit "/admin/applications/#{application1.id}"

    click_on "Reject #{pet1.name} Adoption Request"

    expect(page).to have_content("#{pet1.name} Rejected")

    visit "/admin/applications/#{application2.id}"

    expect(page).to have_content("Application Status: Pending")
    expect(page).to have_button("Approve #{pet1.name}")
    expect(page).to have_button("Reject #{pet1.name} Adoption Request")

    visit "/admin/applications/#{application3.id}"

    expect(page).to have_content("Application Status: Pending")
    expect(page).to have_button("Approve #{pet2.name}")
    expect(page).to have_button("Reject #{pet2.name} Adoption Request")
  end
end
