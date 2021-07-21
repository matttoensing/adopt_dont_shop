
class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def self.find_with_ids(appid, petid)
    PetApplication.where('application_id = ?', appid).where('pet_id = ?', petid).first
  end
end
