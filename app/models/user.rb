class User < ApplicationRecord
  after_initialize do
    if self.new_record?
      self.role ||= :guest
    end
  end
  
  has_secure_password
  has_many :posts
  has_many :comments

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6},
            if: -> { new_record? || !password.nil? }

  enum role: [:guest, :writer, :admin]
end
