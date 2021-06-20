class Opinion < ApplicationRecord
  validates :text, presence: { messge: 'Review content can not be empty.' },
                   length: { minimum: 5, message: 'Review content must be at least 5 characters long.' }

  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :votes
end
