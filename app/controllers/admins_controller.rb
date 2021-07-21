
class AdminsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def approve
    @application = Application.find(params[:id])
    @application.update!(status: "Approved")
    @pet = Pet.find(params[:pet_id])
    @pet.update!(adoptable: false)
    @pet_app = PetApplication.find_with_ids(@application.id, @pet.id)
    @pet_app.update!(status: "Approved")

    render '/admins/_accept'
  end

  def reject
    @application = Application.find(params[:id])
    @application.update!(status: "Rejected")
    @pet = Pet.find(params[:reject])
    @pet_app = PetApplication.find_with_ids(@application.id, @pet.id)
    @pet_app.update!(status: "Rejected")

    render '/admins/_reject'
  end
end
