require "rails_helper"
require "byebug"

RSpec.describe "Comments", type: :request do
  describe "POST /comments" do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }
    it "should create a comment" do
      req_payload = {
        comment: {
          comment: "new comment",
          user_id: user.id,
          post_id: post.id
        }
      }

      post "/comments", params: req_payload

      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(response).to have_http_status(:created)
    end
  end
end