class Attachment < ApplicationRecord
  belongs_to :project
  has_one_attached :file

  before_save :set_format

  private

  def set_format
    self.format = file.blob.content_type if file.attached?
  end
end
