class Api::V1::AnswersController < Api::V1::BaseController
  before_action :load_question, only: [:index, :create]

  respond_to :json

  skip_authorization_check

  def index
    @answers = @question.answers
    respond_with @answers, each_serializer: AnswersListSerializer
  end

  def show
    @answer = Answer.find(params[:id])
    respond_with @answer, serializer: SingleAnswerSerializer
  end

  def create
    respond_with @question.answers.create(answer_params)
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end
end
