
class PetApplicationsController < ApplicationController
  def update
    @application = Application.find(params[:application_id])
    @application.change_status_pending
    @pet = Pet.find(params[:pet_id])
    @petapplication = PetApplication.create!(application_id: params[:application_id], pet_id: params[:pet_id])
    redirect_to(controller: 'applications', action: 'show', id: @application.id, pet: @pet.name)
  end

  # def delete
  #   require "pry"; binding.pry
  #   @application = Application.find(params[:application_id])
  #   @application_rejected = Application.find(params[:application_id])
  #   @application_rejected.change_status_rejected
  #   @pet_rejected = Pet.find(params[:pet_id])
  #   @pet_application = PetApplication.find(params[:id])
  #   redirect_to(controller: 'applications', action: 'show', id: @application.id, pet: @pet.name, reject: "true")
  # end
end
