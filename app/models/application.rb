
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
end
#   def self.find_pet_by_name(search_name)
#     require "pry"; binding.pry
#     # Application.select("pets.name").joins(:pets).where('pets.name LIKE ?', "%#{search_name}%")
#     Application..joins(:pet_applications).joins(:pets).pluck(:name,:'pets.name')
#     # Application.joins(:pets).select('pets.name AS pet_names').where('pets.name LIKE ?', "%#{search_name}%")
#
#       # Application.inner_joins(:pet_applications).joins(:pets).select(:pets).where('pet.name LIKE ?', "%#{name}%")
#   end
# end
