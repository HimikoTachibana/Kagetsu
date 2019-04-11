class Character < ActiveRecord::Base
  belongs_to :user
  has_one :profile
  has_many :comments, dependent: :delete_all
  validates :name, :presence => true, :length => { :in => 3..30 }
  validates :race, :presence => true, :length => { :in => 1..30 }
  validates :physical, numericality: { only_integer: true }, inclusion: { :in => 0..10 }
  validates :magical, numericality: { only_integer: true }, inclusion: { :in => 0..10 }
  validates :special, numericality: { only_integer: true }, inclusion: { :in => 0..10 }
  mount_uploader :image, ImageUploader

private
  def image_size_validation
    errors[:image] << "should be less than 1MB" if image.size > 1.megabytes
  end
end
