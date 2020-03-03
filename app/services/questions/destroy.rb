module Questions
  class Destroy
    def initialize(question)
      @question = question
    end

    def run
      @question.with_lock do
        @question.destroy!
        return true
      end
    rescue
      return false
    end
  end
end
