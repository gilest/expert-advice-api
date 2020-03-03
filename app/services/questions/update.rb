module Questions
  class Update
    attr_reader :question, :params

    def initialize(question, params)
      @question = question
      @params = params
    end

    def run
      process_tags
      update_slug

      if @question.update(params)
        return true
      end

      false
    end

    private

    def process_tags
      @params[:tags] = Questions::ProcessTags.new(params[:tags]).run
    end

    def update_slug
      @params[:slug] = nil
    end
  end
end
