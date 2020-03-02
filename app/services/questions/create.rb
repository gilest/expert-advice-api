module Questions
  class Create
    attr_reader :params, :question

    def initialize(params)
      @params = params
    end

    def run
      @question = Question.new(params)

      if @question.valid?
        @question.save!
        return true
      end

      false
    end
  end
end
