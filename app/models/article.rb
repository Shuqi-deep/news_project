class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  validate :photo_type_and_size

  private

  def photo_type_and_size
    if photo.attached?
      if !photo.content_type.in?(%w(image/jpeg image/png))
        errors.add(:photo, 'must be a JPEG or PNG')
      elsif photo.blob.byte_size > 5.megabytes
        errors.add(:photo, 'size should be less than 5MB')
      end
    end
  end
end
