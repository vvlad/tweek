require 'spec_helper'

describe Api::V1::UsersController do

  let(:valid_attributes) { { email: 'user@example.com', name: 'John Doe'} }

  describe "POST :create" do

    it "should be success" do
      post :create, user: valid_attributes
      response.should be_success
    end

    it "should create a new user" do
      expect{ post :create, user: valid_attributes }.to change(User,:count).by(1)
    end

    it "should present the resource" do
      post :create, user: valid_attributes
      json = JSON.parse(response.body)
      json.should have_key "user"
      user = json["user"]
      user.keys.should eq ["id", "email", "name"]

    end

    context "invalid request" do


      it "should not permit other parameters except :email and :name" do
        expect { post :create, user: { invalid_parameter: 'invalid_parameter'} }.to raise_error(ActionController::UnpermittedParameters)
      end

      it "should have the status  :unprocessable_entity with wrong parameters" do
        post :create, user: { email: 'invalid' }
        response.status.should eq 422
      end

      it "should present the errors" do
        post :create, user: { email: 'invalid' }
        json = JSON.parse(response.body)
        json.should have_key "errors"
      end

      it "should set the status code" do
        post :create, user: { email: 'invalid' }
        json = JSON.parse(response.body)
        json.should have_key "errors"
      end

    end

  end

  describe "PUT :update" do

    let(:user) { User.new(valid_attributes.merge(id: 42)) }

    before do
      User.stub(:find).and_raise(ActiveRecord::RecordNotFound)
      User.stub(:find).with("42").and_return(user)
    end


    it "should be success" do
      put :update, id: "42", user: valid_attributes
      response.should be_success
    end

    it "should present the resource" do
      put :update, id: "42", user: valid_attributes
      json = JSON.parse(response.body)
      json.should have_key "user"
      user = json["user"]
      user.keys.should eq ["id", "email", "name"]

    end

    it "should return 404 Not found" do
      expect { put :update, id: "37", user: valid_attributes }.to raise_error(ActiveRecord::RecordNotFound)
    end


    context "invalid request" do

      it "should not permit other parameters except :email and :name" do
        expect { post :update, id: "42", user: { invalid_parameter: 'invalid_parameter'} }.to raise_error(ActionController::UnpermittedParameters)
      end

      it "should have the status  :unprocessable_entity with wrong parameters" do
        post :create, user: { email: 'invalid' }
        response.status.should eq 422
      end

      it "should present the errors" do
        post :create, user: { email: 'invalid' }
        json = JSON.parse(response.body)
        json.should have_key "errors"
      end

      it "should set the status code" do
        post :create, user: { email: 'invalid' }
        json = JSON.parse(response.body)
        json.should have_key "errors"
      end

    end

  end


  describe "DELETE :destroy " do
    let(:user) { User.new(valid_attributes.merge(id: 42)) }

    before do
      User.stub(:find).and_raise(ActiveRecord::RecordNotFound)
      User.stub(:find).with("42").and_return(user)
    end

    it "should be success" do
      delete :destroy, id: "42"
      response.should be_success
    end

    it "should destroy the resource" do
      user.should_receive(:destroy)
      delete :destroy, id: "42"
    end

  end

end
