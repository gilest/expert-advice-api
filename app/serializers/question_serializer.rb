class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :user, :title, :description, :tags, :views

  def id
    object.slug
  end

  def tags
    object.tags.split(',')
  end
end
