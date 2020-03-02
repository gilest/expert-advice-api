module Questions
  class Create
    attr_reader :params, :question

    def initialize(params)
      @params = params
    end

    def run
      ensure_tags

      @question = Question.new(params)

      if @question.valid?
        @question.save!
        return true
      end

      false
    end

    private

    def ensure_tags
      @params[:tags] = params[:tags] || ''
    end
  end
end
