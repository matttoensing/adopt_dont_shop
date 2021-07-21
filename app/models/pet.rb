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

  def self.pending_applications
    Pet.joins(:pet_applications).where('status = ?', 'Pending')
  end
end
