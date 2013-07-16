class Api::V1::MoviesController < ApplicationController

    def create
    resource_params = params.require(:movie).permit(:title, {genres:[]}, :year)
    respond_with_resource Movie.create(resource_params)
  end

  def update
    resource = Movie.find(params.fetch(:id))
    resource_params = params.require(:movie).permit(:title, {genres:[]}, :year)
    resource.update_attributes(resource_params)
    respond_with_resource resource
  end

  def destroy
    resource = Movie.find(params.fetch(:id))
    resource.destroy
    head :no_content
  end

end
