class Opinion < ApplicationRecord
  validates :text, presence: true, length: { minimun: 3, maximum: 250 }

  belongs_to :author, class_name: 'User'
end
