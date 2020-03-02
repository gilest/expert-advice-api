module Api
  module V1
    class QuestionsController < Api::V1::ApiController
      before_action :doorkeeper_authorize!, except: :index

      def index
        questions = Question.all
        render json: questions
      end

      private

      def user_params
        params.require(:data).require(:attributes).permit(:email, :password)
      end
    end
  end
end
