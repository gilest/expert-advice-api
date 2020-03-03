module Api
  module V1
    class AnswersController < Api::V1::ApiController
      before_action :doorkeeper_authorize!

      def create
        jsonapi = JSON.parse(request.raw_post).fetch("data")

        params = {
          body: jsonapi.dig("attributes", "body"),
          question: Question.friendly.find(jsonapi.dig("relationships", "question", "data", "id")),
          user: current_user
        }

        service = Answers::Create.new(params)

        if service.run
          render json: service.answer
        else
          render json: service.answer, status: 422, serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end
    end
  end
end
