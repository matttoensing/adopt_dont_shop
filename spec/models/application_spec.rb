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
  end

  describe 'class methods' do
    describe '#pets_not_approved' do
      it 'can find all pets not on application that are not the given pet id' do
        shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 5)
        application = create(:application, status: "Approved")
        pet1 = create(:pet, shelter_id: shelter1.id)
        pet2 = create(:pet, shelter_id: shelter1.id)
        pet3 = create(:pet, shelter_id: shelter1.id)
        petapp1 = PetApplication.create!(application_id: application.id, pet_id: pet1.id)
        petapp2 = PetApplication.create!(application_id: application.id, pet_id: pet2.id)
        petapp3 = PetApplication.create!(application_id: application.id, pet_id: pet3.id)

        expected = [pet2, pet3]

        expect(application.pets_not_approved(pet1.id)).to eq(expected)

        expected2 = [pet1, pet2]

        expect(application.pets_not_approved(pet3.id)).to eq(expected2)
      end
    end
  end
end
