
class ApplicationsController < ApplicationController
  def index
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    @application.status = "In Progress"
    @application.save
    if @application.save
      flash.alert = "Unable to Process Request, Forms Missing"
      redirect_to "/applications/#{@application.id}"
    else
      flash.alert = "Unable to Process Request, Forms Missing"
    end
  end

  private

  def application_params
    params.permit(:name, :street, :city, :state, :zip_code, :description)
  end
end
