
class ApplicationsController < ApplicationController
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

    redirect_to "/applications/#{@application.id}"
  end

  private

  def application_params
    params.permit(:name, :street, :city, :state, :zip_code, :description)
  end
end
