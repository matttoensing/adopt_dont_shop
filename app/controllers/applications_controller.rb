
class ApplicationsController < ApplicationController
  def index
  end

  def show
    if params[:search]
      @pets = Pet.find_by_search_name(params[:search])
      @application = Application.find(params[:id])
      require "pry"; binding.pry
    else
      @application = Application.find(params[:id])
    end
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    @application.status = "In Progress"
    @application.save
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:errors] = @application.errors.full_messages
      render 'new'
    end
  end

  private

  def application_params
    params.permit(:name, :street, :city, :state, :zip_code, :description)
  end
end
