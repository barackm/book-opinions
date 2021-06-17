class User < ApplicationRecord
    has_one_attached :photo
    has_one_attached :cover_image

    validates :username, presence: true, uniqueness: true, length: {minimum: 3, maximum: 14}
    validates :full_name, presence: true
    validates_format_of :photo, :with => %r{\.(png|jpg|jpeg)$}i, :message => "Please select only images",:multiline => true
    validates_format_of :cover_image, :with => %r{\.(png|jpg|jpeg)$}i, :message => "Please select only images",:multiline => true

    has_many :opinions, foreign_key: 'author_id'
    has_many :followings, class_name: 'Following', foreign_key: 'follower_id'
    has_many :followed_users, through: :followings, source: :followed 

    def followers
        User.joins(:followings).where(followings: {followed_id: self.id} )
    end

    def people_to_follow
        User.where.not(id: Array.wrap(followed_users)).and(User.where.not(id: self.id))
    end
end
