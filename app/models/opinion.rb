class Opinion < ApplicationRecord
  validates :text, presence: true, length: { minimum: 5 }

  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :votes
end
