require 'spec_helper'

describe Api::V1::MoviesController do
let(:valid_attributes) { { title: 'kpax', year: '2001', genres: %w[Drama Sci-Fi]} }

  describe "POST :create" do

    it "should be success" do
      post :create, movie: valid_attributes
      response.should be_success
    end

    it "should create a new movie" do
      expect{ post :create, movie: valid_attributes }.to change(Movie,:count).by(1)
    end

    it "should present the resource" do
      post :create, movie: valid_attributes
      json = JSON.parse(response.body)
      json.should have_key "movie"
      movie = json["movie"]
      movie.keys.should eq ["id", "title", "genres", "year"]

    end

    context "invalid request" do


      it "should not permit other parameters except :email and :name" do
        expect { post :create, movie: { invalid_parameter: 'invalid_parameter'} }.to raise_error(ActionController::UnpermittedParameters)
      end

      it "should have the status  :unprocessable_entity with wrong parameters" do
        post :create, movie: { year: 'invalid' }
        response.status.should eq 422
      end

      it "should present the errors" do
        post :create, movie: { year: 'invalid' }
        json = JSON.parse(response.body)
        json.should have_key "errors"
      end

      it "should set the status code" do
        post :create, movie: { year: 'invalid' }
        json = JSON.parse(response.body)
        json.should have_key "errors"
      end

    end

  end

  describe "PUT :update" do

    let(:movie) { Movie.new(valid_attributes.merge(id: 42)) }

    before do
      Movie.stub(:find).and_raise(ActiveRecord::RecordNotFound)
      Movie.stub(:find).with("42").and_return(movie)
    end


    it "should be success" do
      put :update, id: "42", movie: valid_attributes
      response.should be_success
    end

    it "should present the resource" do
      put :update, id: "42", movie: valid_attributes
      json = JSON.parse(response.body)
      json.should have_key "movie"
      movie = json["movie"]
      movie.keys.should eq ["id", "title", "genres", "year"]

    end

    it "should return 404 Not found" do
      expect { put :update, id: "37", movie: valid_attributes }.to raise_error(ActiveRecord::RecordNotFound)
    end


    context "invalid request" do

      it "should not permit other parameters except :email and :name" do
        expect { post :update, id: "42", movie: { invalid_parameter: 'invalid_parameter'} }.to raise_error(ActionController::UnpermittedParameters)
      end

      it "should have the status  :unprocessable_entity with wrong parameters" do
        post :create, movie: { year: 'invalid' }
        response.status.should eq 422
      end

      it "should present the errors" do
        post :create, movie: { year: 'invalid' }
        json = JSON.parse(response.body)
        json.should have_key "errors"
      end

      it "should set the status code" do
        post :create, movie: { year: 'invalid' }
        json = JSON.parse(response.body)
        json.should have_key "errors"
      end

    end

  end


  describe "DELETE :destroy " do
    let(:movie) { Movie.new(valid_attributes.merge(id: 42)) }

    before do
      Movie.stub(:find).and_raise(ActiveRecord::RecordNotFound)
      Movie.stub(:find).with("42").and_return(movie)
    end

    it "should be success" do
      delete :destroy, id: "42"
      response.should be_success
    end

    it "should destroy the resource" do
      movie.should_receive(:destroy)
      delete :destroy, id: "42"
    end

  end

end
