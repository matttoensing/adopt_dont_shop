
class AdminsController < ApplicationController
  def index
    @shelters = Shelter.order_in_reverse
  end
end
