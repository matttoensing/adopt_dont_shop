
class PetApplicationsController < ApplicationController
  def update
    @application = Application.find(params[:application_id])
    @pet = Pet.find(params[:pet_id])
    @petapplication = PetApplication.create!(application_id: params[:application_id], pet_id: params[:pet_id])
  end
end
