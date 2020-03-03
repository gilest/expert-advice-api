# Filters Question model based on provided filters
module FilterQuestions
  module_function

  def filter(scope, filter = nil)
    return scope unless filter

    scope.where('LOWER(questions.tags) LIKE LOWER(:search)', search: "%#{filter}%")
  end
end
