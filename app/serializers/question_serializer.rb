class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :tags, :views

  belongs_to :user
  has_many :answers

  def id
    object.slug
  end
end
