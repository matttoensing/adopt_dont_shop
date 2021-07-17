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
    Pet.destroy_all

    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
    application = create(:application)
    pet = create(:pet, age: 6, shelter_id: shelter.id)

    visit "applications/#{application.id}"

    expect(page).to have_content("Add a Pet to this Application")

    fill_in "search", with: pet.name
    click_on 'Submit'

    expect(page).to have_content("Name: #{pet.name}")
    expect(page).to have_content("Breed: #{pet.breed}")
    expect(page).to have_content("Age: #{pet.age}")
    expect(page).to have_content("Adoptable: #{pet.adoptable}")
  end

  it 'next to each pet in the search results is a button add pet to application' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
    application = create(:application)
    pet = create(:pet, age: 6, shelter_id: shelter.id)

    visit "applications/#{application.id}"

    fill_in "search", with: pet.name
    click_on 'Submit'

    expect(page).to have_link("Adopt #{pet.name}")
  end

  it 'user clicks on adopt to add pet to application' do
    Pet.destroy_all

    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
    application = create(:application)
    pet = create(:pet, age: 6, shelter_id: shelter.id)

    visit "applications/#{application.id}"

    fill_in "search", with: pet.name
    click_on 'Submit'
    click_on "Adopt #{pet.name}"

    expect(PetApplication.last.application_id).to eq(application.id)
    expect(PetApplication.last.pet_id).to eq(pet.id)
  end
end
