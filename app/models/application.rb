
class Application < ApplicationRecord
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true
  validates :status, presence: true

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def self.find_pet_by_name(search_name)
    Application.includes(:pets).select("pets.name AS pets_name").where('pets.name LIKE ?', "%#{search_name}%")
    # Application.inner_joins(:pet_applications).joins(:pets).select(:pets).where('pet.name LIKE ?', "%#{name}%")
  end
end
