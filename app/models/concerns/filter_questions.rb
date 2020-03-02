module FilterQuestions
  extend self

  def filter(scope, filter = nil)
    if !filter
      return scope
    end

    scope.where("LOWER(questions.tags) LIKE LOWER(:search)", search: "%#{filter}%")
  end
end
