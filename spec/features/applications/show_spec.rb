require 'rails_helper'

RSpec.describe 'application show page'  do
  it 'shows all applicant information' do
    application = create(:application)

    visit "applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
  end

  it 'has a section where you can search for a specific pet' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
    application = create(:application)
    pet = create(:pet, age: 6, shelter_id: shelter.id)

    visit "applications/#{application.id}"

    expect(page).to have_content("Add a Pet to this Application")

    fill_in "Search For Pets", with: pet.name

    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet.breed)
    expect(page).to have_content(pet.age)
    expect(page).to have_content(pet.adoptable)
#   Searching for Pets for an Application
#
# As a visitor
# When I visit an application's show page
# And that application has not been submitted,
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click submit,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search
  end
end
