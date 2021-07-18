
class AdminsController < ApplicationController
  def index
    @shelters = Shelter.order_in_reverse
    @shelters_with_pends = Shelter.shelters_with_pending_apps
  end

  def show
    if params[:pet_id]
      @application = Application.find(params[:application_id])
      @application.change_status_approved
      @not_approved = @application.pets
      @not_approved = @not_approved.approve_pets(params[:pet_id])
      @approved_pets = Pet.find(params[:pet_id])
    elsif params[:rejection]
      @application = Application.find(params[:application_id])
      @application_rejected = Application.find(params[:application_id])
      @application_rejected.change_status_rejected
      @pet_rejected = Pet.find(params[:pet_id])
    else
      @application = Application.find(params[:id])
      @pets = @application.pets
    end
  end
end
