class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :set_questions, only: [:index, :create]

  authorize_resource

  def index
    respond_with @questions, each_serializer: QuestionsListSerializer
  end

  def show
    @question = Question.find(params[:id])
    respond_with @question, serializer: SingleQuestionSerializer
  end

  def create
    @question = @questions.create(question_params)
    respond_with @question, serializer: SingleQuestionSerializer
  end

  private

  def set_questions
    @questions = Question.all
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy])
  end
end
