class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages, dependent: :destroy
  has_many :projects, dependent: :destroy

  def admin?
    has_role?(:admin)
  end
end
