
class AdminsController < ApplicationController
  def index
    @shelters = Shelter.order_in_reverse
    @shelters_with_pends = Shelter.shelters_with_pending_apps
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end
end
