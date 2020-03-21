require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validations" do
    it "validate presence of comment" do
      should validate_presence_of(:coment)
    end
  end
end
