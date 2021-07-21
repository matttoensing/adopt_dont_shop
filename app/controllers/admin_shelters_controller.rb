
class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_in_reverse
    @shelters_with_pends = Shelter.shelters_with_pending_apps
  end

  def show
    @shelter = Shelter.find(params[:id])
    @number_of_pets = Shelter.number_of_adoptions(@shelter.id)
    @pets_pending = @shelter.pets.pending_applications
  end
end
