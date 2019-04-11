class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :character
  validates :nickname, :presence => true, :length => { :in => 3..30 }
  validates :gender, inclusion: { in: [0, 1, 2] }
  mount_uploader :image, ImageUploader

private
  def image_size_validation
    errors[:image] << "should be less than 1MB" if image.size > 1.megabytes
  end
end
