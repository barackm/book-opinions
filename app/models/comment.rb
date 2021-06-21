class Comment < ApplicationRecord
  validates :content, presence: true, length: { minimum: 5 }
  belongs_to :user
  belongs_to :opinion
end
