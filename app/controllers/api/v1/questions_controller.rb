module Api::V1
  class QuestionsController < BaseController
    def index
      @questions = Question.all
      respond_with @questions, each_serializer: QuestionsSerializer
    end

    def show
      respond_with @question = Question.find(params[:id])
    end
  end
end