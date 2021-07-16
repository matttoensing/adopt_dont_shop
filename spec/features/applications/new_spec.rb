require 'rails_helper'

RSpec.describe 'new application page' do
  it 'user can create a new application and submit it' do
    visit new_application_path

    fill_in "application[name]", with: "Lauren Wilson"
    fill_in "application[street]", with: "3425 S. Huntington Pl"
    fill_in "application[city]", with: "Denver"
    fill_in "application[state]", with: "CO"
    fill_in "application[zip_code]", with: "80302"
    fill_in "application[description]", with: "I love Animals and want to adopt a new pet to look after"

    click_on "Create Application"

    expect(page).to have_content("Lauren Wilson")
    expect(page).to have_content("3425 S. Huntington Pl")
    expect(page).to have_content("Denver, CO 80302")
    expect(page).to have_content("I love Animals and want to adopt a new pet to look after")
    expect(page).to have_content("Application Status: In Progress")
  end
end
