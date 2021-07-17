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
    PetApplication.destroy_all
    Pet.destroy_all
    Application.destroy_all

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

    expect(page).to have_button("Adopt #{pet.name}")
  end

  it 'user clicks on adopt to add pet to application' do
    Pet.destroy_all
    Shelter.destroy_all
    Application.destroy_all

    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
    application = create(:application)
    pet = create(:pet, age: 6, shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    fill_in "search", with: pet.name
    click_on 'Submit'
    click_on "Adopt #{pet.name}"

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("Pets Applied For: #{pet.name}")
    expect(page).to have_link("#{pet.name}")
    expect(PetApplication.last.application_id).to eq(application.id)
    expect(PetApplication.last.pet_id).to eq(pet.id)
  end

  it 'shows an input field for description of good pet owner with a submit button' do
    Pet.destroy_all
    Shelter.destroy_all
    Application.destroy_all

    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
    application = create(:application)
    pet = create(:pet, age: 6, shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    fill_in "search", with: pet.name
    click_on 'Submit'
    click_on "Adopt #{pet.name}"

    fill_in "description", with: "I Love Animals!"

    expect(page).to have_button("Submit Description")
  end

  it 'can submit button to show application pending' do
    Pet.destroy_all
    Shelter.destroy_all
    Application.destroy_all

    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
    application = create(:application)
    pet = create(:pet, age: 6, shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    fill_in "search", with: pet.name
    click_on 'Submit'
    click_on "Adopt #{pet.name}"

    fill_in "description", with: "I Love Animals!"
    click_on "Submit Description"

    expect(application.status).to eq("Pending")
    expect(page).to have_content("Pending")

    # As a visitor
    # When I visit an application's show page
    # And I have added one or more pets to the application
    # Then I see a section to submit my application
    # And in that section I see an input to enter why I would make a good owner for these pet(s)
    # When I fill in that input
    # And I click a button to submit this application
    # Then I am taken back to the application's show page
    # And I see an indicator that the application is "Pending"
    # And I see all the pets that I want to adopt
    # And I do not see a section to add more pets to this application
  end
end
