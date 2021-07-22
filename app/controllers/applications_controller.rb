
class ApplicationsController < ApplicationController
  def index
  end

  def show
    if params[:search].present?
      @application = Application.find(params[:id])
      @pets = Pet.find_by_search_name(params[:search])
      @applied_for = @application.pets if !@application.pets.nil?
    else
      @application = Application.find(params[:id])
    end

    if params[:pet]
      @application = Application.find(params[:id])
      @pet_on_app = @application.pets
    end

    if params[:description]
      @application = Application.find(params[:id])
      @pets_for_app = @application.pets
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

  def update
    @application = Application.find(params[:id])
    @application.update({description: params[:description], status: "Pending"})
    @pets_for_app = @application.pets

    redirect_to(controller: 'applications', action: 'show', id: @application.id, description: "true")
  end

  private

  def application_params
    params.permit(:name, :street, :city, :state, :zip_code, :description)
  end
end
