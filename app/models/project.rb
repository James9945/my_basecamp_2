class Project < ApplicationRecord
    has_many :attachments, dependent: :destroy
  end
  