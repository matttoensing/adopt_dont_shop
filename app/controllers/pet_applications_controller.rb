
class PetApplicationsController < ApplicationController
  def update
    application = Application.find(params[:application_id])
    application.change_status_pending
    pet = Pet.find(params[:pet_id])
    petapplication = PetApplication.create!(application_id: params[:application_id], pet_id: params[:pet_id], status: "Pending")

    redirect_to(controller: 'applications', action: 'show', id: application.id, pet: pet.name)
  end
end
