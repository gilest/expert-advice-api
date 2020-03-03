module Questions
  # CRUD service for destroying Question model objects
  class Destroy
    def initialize(question, current_user)
      @question = question
      @current_user = current_user
    end

    def run
      unless can_destroy?
        @question.errors.add(:base, 'You are not permitted to delete this question')
        return false
      end

      @question.with_lock do
        @question.destroy!
        return true
      end
    end

    private

    def can_destroy?
      @current_user == @question.user
    end
  end
end
