class Question < ApplicationRecord
  belongs_to :user

  validates :title, :description, presence: true

  extend FriendlyId
  friendly_id :title, use: :slugged
end
