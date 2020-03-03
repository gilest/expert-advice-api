module Answers
  # CRUD service for creating Answer model objects
  class Create
    attr_reader :params, :answer

    def initialize(params)
      @params = params
    end

    def run
      @answer = Answer.new(params)

      if @answer.valid?
        @answer.save!
        return true
      end

      false
    end
  end
end
