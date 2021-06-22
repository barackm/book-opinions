class Comment < ApplicationRecord
  validates :content, presence: true, length: { minimum: 5 }
  belongs_to :user
  belongs_to :opinion

  scope :order_by_most_recent, -> { includes(:user).order(created_at: :desc) }
end
