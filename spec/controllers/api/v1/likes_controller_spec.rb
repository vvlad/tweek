require 'spec_helper'

describe Api::V1::LikesController do

  fixtures(:users, :movies)

  let(:user) { users(:one) }
  let(:movie) { movies(:one) }

  describe "POST :create" do

    it "should be success" do
      post :create, movie_id: movie.id, user_id: user.id
      response.should be_success
    end

    it "should create a like for a moive" do
      expect { post :create, movie_id: movie.id, user_id: user.id }.to change(Like,:count).by(1)
    end

    context "invalid actions" do
      before { Like.create! movie: movie, user: user }

      it "should not create a like if one already exist" do
        expect { post :create, movie_id: movie.id, user_id: user.id }.not_to change(Like,:count)
      end

      it "should not be success" do
        post :create, movie_id: movie.id, user_id: user.id
        response.should_not be_success
      end

    end
  end

  describe "POST :destroy" do

    before { Like.create user_id: user.id, movie_id: movie.id }

    it "should be success" do
      delete :destroy, movie_id: movie.id, user_id: user.id
      response.should be_success
    end

    it "should delete a like for a movie" do
      expect { delete :destroy, movie_id: movie.id, user_id: user.id }.to change(Like, :count).by(-1)
    end

    it "should be success even if the association doesn't exist" do
      delete :destroy, movie_id: movies(:two).id, user_id: user.id
      response.should be_success
    end

  end


end
