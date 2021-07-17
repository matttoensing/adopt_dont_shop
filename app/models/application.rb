
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

  def self.pets_on_application(petid)
    # Application.select('pets.*').joins(:pets).where('pet_id = ?', petid)
    # Application.find_by_sql(Pet.joins(:applications).where('pet_id = ?', petid).select("DISTINCT pets.*").to_sql)
    # Application.left_joins(:pets).where('pet_applications.pet_id = ?', petid).select('pets.*')
    Application.joins(:pets).where('pet_id = ?', petid).select('pets.*')
  end
end
