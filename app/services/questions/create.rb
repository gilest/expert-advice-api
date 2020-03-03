module Questions
  # CRUD service for creating Question model objects
  class Create
    attr_reader :params, :question

    def initialize(params)
      @params = params
    end

    def run
      process_tags

      @question = Question.new(params)

      if @question.valid?
        @question.save!
        return true
      end

      false
    end

    private

    def process_tags
      @params[:tags] = Questions::ProcessTags.new(params[:tags]).run
    end
  end
end
