class Api::V1::QuestionsController < Api::V1::BaseController
  skip_authorization_check

  def index
    @questions = Question.all
    respond_with @questions, each_serializer: QuestionsListSerializer
  end

  def show
    @question = Question.find(params[:id])
    respond_with @question, serializer: SingleQuestionSerializer
  end
end
