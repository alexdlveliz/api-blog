class Category < ApplicationRecord
  belongs_to :post, optional: true
  validates :name_category, presence: true
end
