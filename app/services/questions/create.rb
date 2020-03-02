module Questions
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

    # Processes tag data into a consistent format
    def process_tags
      if !params[:tags]
        @params[:tags] = ''
        return
      end

      @params[:tags] = params[:tags]
                       .downcase
                       # Replace all unwanted chars with a space
                       .gsub(/[^a-z1-9,]/, ' ')
                       # Replace all sections of whitespace with a single space
                       .gsub(/\s+/, ' ')
                       .split(',')
                       .uniq
                       .sort
                       .join(',')
    end
  end
end
