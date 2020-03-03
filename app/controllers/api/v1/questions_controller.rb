module Api
  module V1
    class QuestionsController < Api::V1::ApiController
      before_action :doorkeeper_authorize!, except: %i[index record_view]

      def index
        filter = params[:filter]
        page = params[:page].to_i || 1

        questions = FilterQuestions.filter(Question.all, filter)
        questions = SortQuestions.sort(questions, 'created_at', 'desc')
        questions = questions.page(page).per(questions_per_page)

        render json: questions,
               meta: { page: { pages: questions.total_pages } }
      end

      def show
        question = Question.friendly.find(params[:id])

        render json: question, include: %i[user answers]
      end

      def create
        jsonapi = JSON.parse(request.raw_post).fetch('data')

        params = {
          title: jsonapi.dig('attributes', 'title'),
          description: jsonapi.dig('attributes', 'description'),
          tags: jsonapi.dig('attributes', 'tags'),
          user: current_user
        }

        service = Questions::Create.new(params)

        if service.run
          render json: service.question
        else
          render json: service.question, status: 422, serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def update
        question = Question.find(params[:id])

        jsonapi = JSON.parse(request.raw_post).fetch('data')

        params = {
          title: jsonapi.dig('attributes', 'title'),
          description: jsonapi.dig('attributes', 'description'),
          tags: jsonapi.dig('attributes', 'tags')
        }

        service = Questions::Update.new(question, params, current_user)

        if service.run
          render json: service.question
        else
          render json: service.question, status: 422, serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      def record_view
        success = Question.increment_views(params[:id])
        response_code = success ? 204 : 404

        head response_code
      end

      def destroy
        question = Question.find(params[:id])
        service = Questions::Destroy.new(question, current_user)

        if service.run
          head 204
        else
          head 422
        end
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
