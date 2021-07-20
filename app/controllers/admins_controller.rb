
class AdminsController < ApplicationController
  def index
    @shelters = Shelter.order_in_reverse
    @shelters_with_pends = Shelter.shelters_with_pending_apps
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:pet_id]
      @all_approved_pets = @application.pets.approved
      @not_approved = @application.pets.not_approved(params[:pet_id])
      require "pry"; binding.pry
      # @all_approved_pets = @application.pets
      # @all_approved_pets = @all_approved_pets.approved
      # @not_approved = @application.pets
      # @not_approved.not_approved(params[:pet_id])
    else params[:reject]
      @application_rejected = Application.find(params[:id])
      @pet_rejected = Pet.find_by_application_id(params[:id])
    end
  end

  def approve
    @application = Application.find(params[:id])
    @application.update!(status: "Approved")
    @pet = Pet.find(params[:pet_id])
    @pet.update!(adoptable: false)

    redirect_to(controller: 'admins', action: 'show', id: @application.id, reject: "true")
  end

  def reject
    @application = Application.find(params[:id])
    @application.update!(status: "Rejected")

    redirect_to(controller: 'admins', action: 'show', id: @application.id, reject: "true")
  end
end
