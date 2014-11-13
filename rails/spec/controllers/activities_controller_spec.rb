require 'rails_helper'

RSpec.describe ActivitiesController, :type => :controller do

  describe "GET points" do
    it "returns http success" do
      get :points
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET workouts" do
    it "returns http success" do
      get :workouts
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET users" do
    it "returns http success" do
      get :users
      expect(response).to have_http_status(:success)
    end
  end

end
