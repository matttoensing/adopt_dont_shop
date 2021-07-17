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
    describe '#find_pet_by_name' do
      xit 'can find a pet by a given name' do
        shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: true, rank: 9)
        application = create(:application)
        pet1 = create(:pet, age: 6, shelter_id: shelter.id)
        pet2 = create(:pet, age: 8, shelter_id: shelter.id)
        pet3 = create(:pet, age: 2, shelter_id: shelter.id)
        pet4 = create(:pet, age: 3, shelter_id: shelter.id)

        expect(Application.find_pet_by_name(pet2.name)).to eq([pet2])
        expect(Application.find_pet_by_name(pet4.name)).to eq([pet4])
      end
    end
  end
end
