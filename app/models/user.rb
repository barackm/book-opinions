class User < ApplicationRecord
  has_one_attached :photo
  has_one_attached :cover_image
  before_save :populate_images

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 14 }
  validates :full_name, presence: true
  validates :photo, blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'], size_range: 1..2.megabytes }
  validates :cover_image, blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'], size_range: 1..2.megabytes }
  validates :photo, presence: false
  validates :cover_image, presence: false

  has_many :opinions, foreign_key: 'author_id', class_name: 'Opinion'
  has_many :followings, class_name: 'Following', foreign_key: 'follower_id'
  has_many :following_users, through: :followings, source: :followed

  def followers
    User.joins(:followings).where(followings: { followed_id: id })
  end

  def people_to_follow
    User.where.not(id: Array.wrap(following_users)).and(User.where.not(id: id))
  end

  def timeline_opinions 
    Opinion.where(author: (following_users.to_a << self)).order("created_at DESC")
  end

  def following?(follower)
    !following_users.where(id: follower.id).empty?
  end

  private

  def populate_images
    # cover_images = ["cover1.jpg","cover2.jpg","cover3.jpg","cover1.jpg","cover5.jpg","cover6.jpg","cover7.jpg",].sample
    # avatar_images = ["av1.png","av2.png","av3.png","av4.png","av5.png","av6.png","av7.png","av8.png"].sample
    self.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'avatar.png')), filename: 'avatar.png', content_type: 'image/jpg') if !self.photo.attached? 
    self.cover_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'cover11.jpg')), filename: 'cover11.jpg', content_type: 'image/png') if !self.cover_image.attached? 
    # self.cover_image = cover_images if self.photo.nil?

    
  end

end
