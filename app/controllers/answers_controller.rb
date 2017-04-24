class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_question, only: [:create]

  # def new
  #   @answer = @question.answers.new
  # end

  def show
    @answer = Answer.find(params[:id])
  end

  def create
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to @answer, notice: 'Your answer was successfully created'
    else
      flash[:alert] = @answer.errors.full_messages
      redirect_to @question
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
