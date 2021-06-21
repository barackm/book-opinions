class User < ApplicationRecord
  has_one_attached :photo
  has_one_attached :cover_image
  before_save :populate_images, :format_username
  before_update :format_username

  validates :username, presence: true, uniqueness: true,
                       length: { minimum: 3, maximum: 14, message: 'Username must have 3 to 14 characters.' }
  validates :full_name, presence: true
  validates :photo,
            blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'], size_range: 1..2.megabytes,
                    message: 'Photo must be 2Mb or less, and either jpg, jpeg, png' }
  validates :cover_image,
            blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'], size_range: 1..2.megabytes,
                    message: 'Cover image must be 2Mb or less, and either jpg, jpeg, png' }
  validates :photo, presence: false
  validates :cover_image, presence: false

  has_many :opinions, foreign_key: 'author_id', class_name: 'Opinion'
  has_many :comments
  has_many :votes
  has_many :followings, class_name: 'Following', foreign_key: 'follower_id'
  has_many :following_users, through: :followings, source: :followed

  def followers
    User.joins(:followings).where(followings: { followed_id: id })
  end

  def people_to_follow
    User.where.not(id: Array.wrap(following_users)).and(User.where.not(id: id)).order('created_at DESC')
  end

  def timeline_opinions
    Opinion.where(author: (following_users.to_a << self)).order('created_at DESC')
  end

  def following?(follower)
    !following_users.where(id: follower.id).empty?
  end

  private

  def populate_images
    unless photo.attached?
      photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'avatar.png')), filename: 'avatar.png',
                   content_type: 'image/jpg')
    end

    return if cover_image.attached?

    cover_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'cover11.jpg')),
                       filename: 'cover11.jpg', content_type: 'image/png')
  end

  def format_username
    self.username = username.delete(' ').downcase
  end
end
