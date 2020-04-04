class Category < ApplicationRecord
  belongs_to :post
  validates :name_category, presence: true
end
