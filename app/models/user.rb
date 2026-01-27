class User < ApplicationRecord
  has_secure_password
  has_many :user_sessions, dependent: :destroy
  has_many :loans
  validates :user_type, presence: true

  before_validation :set_default_user_type, on: :create

  def admin?
    user_type == "admin"
  end

  private

  def set_default_user_type
    self.user_type ||= "user"
  end
end
