class User < ActiveRecord::Base
  has_one :profile
  has_many :characters
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :comments, dependent: :delete_all
  has_many :rooms,dependent: :destroy
  attr_accessor :password
  attr_accessor :profile_id

  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..30 }
  validates :password, :confirmation => true #password_confirmation attribute
  validates_length_of :password, :in => 3..30, :on => :create

  before_save :encrypt_password
  before_save :create_profile
  after_save :clear_password

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  def clear_password
	self.password_hash = nil
  end

  def self.authenticate(username, password)
    user = User.where(username: username).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def create_profile
	adjs = ["autumn", "hidden", "bitter", "misty", "silent", "empty", "dry", "dark"]
	nouns = ["waterfall", "river", "breeze", "moon", "rain", "wind", "sea", "morning"]
    self.profile = Profile.create(:nickname => [adjs.sample, nouns.sample].join('_'), :gender => 0)
  end



  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end

  def except_current_user(users)
    users.reject{ |user| user.id == self.id }
  end

  def self.search(param)
    return User.none if param.blank?
    param.downcase!
    (username_matches(param)).uniq 
  end

  def self.username_matches(param)
    matches('username', param)
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) like ?", "%#{param}%")
  end
end

