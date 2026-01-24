class User < ApplicationRecord
  has_secure_password
  has_many :user_sessions, dependent: :destroy
  has_many :loans
end
