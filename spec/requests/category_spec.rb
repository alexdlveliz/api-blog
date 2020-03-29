require "rails_helper"

RSpec.describe "categories", type: :request do

  describe "POST /categories" do
    it "should create a category" do
      req_payload = {
        name_category: "new category"
      }

      post "/categories", params: req_payload

      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(response).to have_http_status(:created)
    end
  end
  
  describe "GET /categories" do
    let!(:category){
      create_list(:category, 5)
    }
    it "should create all the categories" do
      get "/categories"

      payload = JSON.parse(response.body)
      expect(payload.size).to eq(category.size)
      expect(response).to have_http_status(:ok)
    end
  end
end