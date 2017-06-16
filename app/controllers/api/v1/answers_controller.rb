class Api::V1::AnswersController < Api::V1::BaseController
  before_action :load_question

  skip_authorization_check

  def index
    @answers = @question.answers
    respond_with @answers, each_serializer: AnswersListSerializer
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end
end
