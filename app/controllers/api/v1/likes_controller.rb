class Api::V1::LikesController < ApplicationController

  def create
    respond_with_resource movie.likes.create(user: user)
  end
  def destroy
    # resoruce Like.where(user_id: params.fetch(:user_id), movie_id: params.fetch(:movie_id))
    resource = Like.find_by_user_id_and_movie_id(params.fetch(:user_id), params.fetch(:movie_id))
    resource.try(:destroy)
    head :no_content
  end

  private
  def user
    @user ||= User.find params.fetch(:user_id)
  end

  def movie
    @movie ||= Movie.find params.fetch(:movie_id)
  end

end
