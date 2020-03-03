class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :user, :title, :description, presence: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.increment_views(id)
    where(id: id).update_all('views = views + 1')
  end
end
