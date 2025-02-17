class Project < ApplicationRecord
    has_many_attached :attachments, dependent: :destroy
    has_many :discussions, dependent: :destroy
    belongs_to :user
  end
  