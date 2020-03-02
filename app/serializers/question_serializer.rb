class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :user, :title, :description, :tags, :views, :slug

  def tags
    object.tags.split(',')
  end
end
