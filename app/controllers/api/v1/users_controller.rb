class Api::V1::UsersController < ApplicationController


  def create
    resource_params = params.require(:user).permit(:email, :name)
    respond_with_resource User.create(resource_params)
  end

  def update
    resource = User.find(params.fetch(:id))
    resource_params = params.require(:user).permit(:email, :name)
    resource.update_attributes(resource_params)
    respond_with_resource resource
  end

  def destroy
    resource = User.find(params.fetch(:id))
    resource.destroy
    head :no_content
  end

end
