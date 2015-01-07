class Picture < ActiveRecord::Base
  belongs_to :question
  mount_uploader :image, ImageUploader
  validates :image, presence: true
end
