module SortQuestions
  extend self

  def sort(scope, key = nil, direction = nil)
    key = key.presence || "created_at"
    direction = parse_direction(direction)

    case key
    when "created_at"
      sort_by_column(scope, key, direction)
    else
      raise ArgumentError, "very bad"
    end
  end

  private

  def parse_direction(value)
    value.in?(%w(asc desc)) ? value : "asc"
  end

  def sort_by_column(scope, column, direction)
    scope
      .order(column => direction)
      .order('questions.id')
  end
end
