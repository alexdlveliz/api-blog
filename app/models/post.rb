class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  
  validates :title, presence: true
  validates :content, presence: true
  validates :published, presence: true
  validates :user_id, presence: true
end
