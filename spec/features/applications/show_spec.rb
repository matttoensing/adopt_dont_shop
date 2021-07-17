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

    expect(page).to have_button("Submit Application")
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
    click_on "Submit Application"

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("Pending")
    expect(page).to have_content("Pets Applied For: #{pet.name}")
    expect(page).to_not have_button('Submit')
    expect(page).to_not have_content("Add a Pet to this Application")
  end

  it 'will not desplay a text field to enter description if no pets are added to application' do
    Pet.destroy_all
    Shelter.destroy_all
    Application.destroy_all

    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
    application = create(:application)
    pet = create(:pet, age: 6, shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    fill_in "search", with: pet.name
    click_on 'Submit'

    expect(page).to_not have_button("Submit Application")
  end

  it 'will display pets on page with partial lower case name search' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
    application = create(:application)
    pet1 = create(:pet, name: "Fluffy", shelter_id: shelter.id)
    pet2 = create(:pet, name: "Baxter", shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    fill_in "search", with: "baxt"
    click_on 'Submit'

    expect(page).to have_content("Baxter")
    expect(page).to have_content("#{pet2.age}")
    expect(page).to have_content(pet2.breed)
    expect(page).to have_content(pet2.adoptable)

    visit "/applications/#{application.id}"

    fill_in "search", with: "fluf"
    click_on 'Submit'

    expect(page).to have_content("Fluffy")
    expect(page).to have_content("#{pet1.age}")
    expect(page).to have_content(pet1.breed)
    expect(page).to have_content(pet1.adoptable)
  end
end
