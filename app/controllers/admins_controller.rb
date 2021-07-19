
class AdminsController < ApplicationController
  def index
    @shelters = Shelter.order_in_reverse
    @shelters_with_pends = Shelter.shelters_with_pending_apps
  end

  def show

    if params[:pet_id]
      @approved_pets = []
      @application = Application.find(params[:application_id])
      @application.change_status_approved
      @approved_pets << Pet.find(params[:pet_id])
      @not_approved = @application.pets_not_approved(params[:pet_id])
    elsif params[:reject]
      @application_rejected = Application.find(params[:id])
      @application_rejected.change_status_rejected
      @pet_rejected = Pet.find_by_application_id(params[:id])
    else
      @application = Application.find(params[:id])
      @pets = @application.pets
    end
  end

  def delete
    @application_rejected = Application.find(params[:id])
    @application_rejected.change_status_rejected
    @pet_application = PetApplication.find_by_application_id(params[:id])
    # @pet_application.destroy
    redirect_to(controller: 'admins', action: 'show', id: @application_rejected.id, reject: "true")
  end
end
