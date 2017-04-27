class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_answer, only: [:show, :destroy]
  before_action :set_question, only: [:create]

  def show
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @answer, notice: 'Your answer was successfully created'
    else
      flash[:alert] = @answer.errors.full_messages
      render 'questions/show'
    end
  end

  def destroy
    if current_user && current_user.author_of?(@answer)
      @answer.destroy
      redirect_to question_path(@answer.question), notice: 'Your answer successfully deleted'
    else
      redirect_to questions_path, notice: 'You do not have permission to delete this answer'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
