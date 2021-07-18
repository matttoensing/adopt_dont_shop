class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  validates :breed, presence: true
  # validates :adoptable, inclusion: [true, false]

  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.find_by_search_name(search)
    Pet.where('lower(name) LIKE ?', "%#{search.downcase}%")
  end

  def self.approve_pets(petid)
    Pet.includes(:applications).references(:applications).where.not('pets.id = ?', petid)
  end

  def self.find_by_application_id(appid)
    Pet.includes(:pet_applications).references(:applications).where('application_id = ?', appid)
  end
end
