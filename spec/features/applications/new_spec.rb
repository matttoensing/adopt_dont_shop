require 'rails_helper'

RSpec.describe 'new application page' do
  it 'user can create a new application and submit it' do
    visit '/applications/new'

    fill_in "name", with: "Lauren Wilson"
    fill_in "street", with: "3425 S. Huntington Pl"
    fill_in "city", with: "Denver"
    fill_in "state", with: "CO"
    fill_in "zip_code", with: "80302"

    click_on "Create Application"

    expect(page).to have_content("Lauren Wilson")
    expect(page).to have_content("3425 S. Huntington Pl")
    expect(page).to have_content("Denver, CO 80302")
    expect(page).to have_content("Application Status: In Progress")
  end

  it 'shows an error if application is not completed' do
    visit '/applications/new'

    fill_in "street", with: "3425 S. Huntington Pl"
    fill_in "city", with: "Denver"
    fill_in "state", with: "CO"
    fill_in "zip_code", with: "80302"

    click_on "Create Application"

    expect(page).to have_content("Name can't be blank")
  end
end
