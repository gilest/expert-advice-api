module Questions
  # CRUD service for updating Question model objects
  class Update
    attr_reader :question, :params, :current_user

    def initialize(question, params, current_user)
      @question = question
      @params = params
      @current_user = current_user
    end

    def run
      unless can_update?
        @question.errors.add(:base, 'You are not permitted to update this question')
        return false
      end

      process_tags
      update_slug

      return true if @question.update(params)

      false
    end

    private

    def can_update?
      current_user == question.user
    end

    def process_tags
      @params[:tags] = Questions::ProcessTags.new(params[:tags]).run
    end

    def update_slug
      @params[:slug] = nil
    end
  end
end
