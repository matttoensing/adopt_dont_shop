class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def adoptable_pets_count
    pets.where(adoptable: true).count
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end

  def average_pet_age
    self.pets.average(:age).to_i
  end

  def self.order_in_reverse
    Shelter.find_by_sql('SELECT * FROM shelters ORDER BY shelters.name desc')
  end

  def self.shelters_with_pending_apps
    Shelter.joins(pets: [:pet_applications]).where('status = ?', 'Pending').distinct
  end

  def self.order_by_name
    Shelter.order(:name)
  end

  def self.number_of_adoptions(shelterid)
    Shelter.select('shelters.id AS shelter_id').joins(pets: [:pet_applications]).where('shelter_id = ?', shelterid).where('status = ?', "Approved").count('status')
  end

  def self.full_address(shelterid)
    Shelter.find_by_sql("SELECT CONCAT(street_number, ' ', street_name, ' ', city,', ', state_name, ' ',zip_code) AS address FROM shelters WHERE id = #{shelterid}").pluck(:address).first
  end
end
