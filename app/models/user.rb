class User < ApplicationRecord
  has_one_attached :photo
  has_one_attached :cover_image

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 14 }
  validates :full_name, presence: true
  validates :photo, blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'], size_range: 1..2.megabytes }
  validates :cover_image, blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png'], size_range: 1..2.megabytes }
  validates :photo, presence: false
  validates :cover_image, presence: false

  has_many :opinions, foreign_key: 'author_id'
  has_many :followings, class_name: 'Following', foreign_key: 'follower_id'
  has_many :followed_users, through: :followings, source: :followed

  def followers
    User.joins(:followings).where(followings: { followed_id: id })
  end

  def people_to_follow
    User.where.not(id: Array.wrap(followed_users)).and(User.where.not(id: id))
  end
end
