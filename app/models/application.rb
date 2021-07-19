
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

  def change_status_pending
    self.status = "Pending"
  end

  def change_status_approved
    self.status = "Approved"
  end

  def change_status_rejected
    self.status = "Rejected"
  end

  def pets_not_approved(petid)
    self.pets.where.not('pet_id = ?', petid)
  end
end
