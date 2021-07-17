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
  end
end
