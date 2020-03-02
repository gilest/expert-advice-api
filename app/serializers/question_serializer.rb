class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :user, :title, :description, :tags, :views

  def tags
    object.tags.split(',')
  end
end
