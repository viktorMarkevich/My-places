class User < ApplicationRecord
  has_secure_password

  validates :email, :name, :password, :password_confirmation, presence: true, on: :create
  validates :email, :name, :password, presence: true, on: :update

  enum role: %i[user admin].freeze

  scope :user_list, -> { where(role: 'user') }

  def admin?
    role == 'admin'
  end
end
