
class PetApplicationsController < ApplicationController
  def update
    @petapplication = PetApplication.create!(application_id: params[:application_id], pet_id: params[:pet_id])
  end
end
