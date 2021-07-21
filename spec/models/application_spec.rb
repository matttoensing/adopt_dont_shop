require 'rails_helper'

RSpec.describe Application do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:description) }
  end

  describe 'instance methods' do
    describe '#change_status_pending' do
      it 'can change application status from in progress to pending' do
        shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
        application = create(:application)

        application.change_status_pending

        expect(application.status).to eq("Pending")
      end
    end

    describe '#change_status_approved' do
      it 'can change application status from pending to approved' do
        shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
        application = create(:application)

        application.change_status_approved

        expect(application.status).to eq("Approved")
      end
    end

    describe '#change_status_rejected' do
      it 'can change application pending from pending to rejected' do
        shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
        application = create(:application)

        application.change_status_rejected

        expect(application.status).to eq("Rejected")
      end
    end

    describe '#find_pet_apps' do
      xit 'can find all pet applications for an application' do
        shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
        application1 = create(:application)
        application2 = create(:application)
        pet1 = create(:pet, shelter_id: shelter.id)
        pet2 = create(:pet, shelter_id: shelter.id)
        pet3 = create(:pet, shelter_id: shelter.id)
        pet4 = create(:pet, shelter_id: shelter.id)
        pet5 = create(:pet, shelter_id: shelter.id)
        pet_app1 = PetApplication.create!(pet_id: pet1.id, application_id: application1.id, status: "Pending")
        pet_app2 = PetApplication.create!(pet_id: pet2.id, application_id: application1.id, status: "Pending")
        pet_app3 = PetApplication.create!(pet_id: pet3.id, application_id: application1.id, status: "Pending")
        pet_app4 = PetApplication.create!(pet_id: pet3.id, application_id: application2.id, status: "Pending")
        pet_app5 = PetApplication.create!(pet_id: pet1.id, application_id: application2.id, status: "Pending")

        expected = [pet_app1, pet_app2, pet_app3]

        expect(application1.find_pet_apps).to eq(expected)
      end
    end
  end
end
