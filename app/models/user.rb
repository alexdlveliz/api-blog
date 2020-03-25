class User < ApplicationRecord
  has_many :posts
  has_many :comments

  validates :email, presence: true
  validates :name, presence: true
  validates :password_digest, presence: true
end
