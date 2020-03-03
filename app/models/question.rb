class Question < ApplicationRecord
  belongs_to :user
  has_many :answers

  validates :user, :title, :description, presence: true

  extend FriendlyId
  friendly_id :title, use: :slugged
end
