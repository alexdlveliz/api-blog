class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  belongs_to :category
  validates :title, presence: true
  validates :content, presence: true
  validates :published, inclusion: { in: [true, false]}
  validates :user_id, presence: true
end
