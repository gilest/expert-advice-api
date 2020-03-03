class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :user, :title, :description, :tags, :views

  has_many :answers

  def id
    object.slug
  end
end
