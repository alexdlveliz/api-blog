require "rails_helper"
require "byebug"

RSpec.describe "Comments", type: :request do
  describe "POST /comments" do
    it "should create a comment" do
      req_payload = {
        comment: {
          content: "new comment",
          user_id: 1,
          post_id: 1
        }
      }

      post "/comments", params: req_payload

      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(response).to have_http_status(:created)
    end
  end
end