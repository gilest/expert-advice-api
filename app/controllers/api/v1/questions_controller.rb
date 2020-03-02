module Api
  module V1
    class QuestionsController < Api::V1::ApiController
      before_action :doorkeeper_authorize!, except: :index

      def index
        page = params[:page].to_i || 1

        questions = SortQuestions.sort(Question.all, "created_at", "desc")
        questions = questions.page(page).per(questions_per_page)

        render json: questions, meta: { page: { pages: questions.total_pages } }
      end

      private

      def user_params
        params.require(:data).require(:attributes).permit(:email, :password)
      end

      def questions_per_page
        5
      end
    end
  end
end
