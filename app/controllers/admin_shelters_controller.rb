
class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_in_reverse
    @shelters_with_pends = Shelter.shelters_with_pending_apps
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end
