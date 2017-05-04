class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:destroy]
  before_action :set_question, only: [:create]


  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    @answer.save
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params) if current_user.author_of?(@answer)
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      respond_to do |format|
        format.html { redirect_to question_path(@answer.question),
          notice: 'Your answer successfully deleted' }
        format.js
      end
    else
      redirect_to questions_path, notice: 'You do not have permission to delete this answer'
    end
  end

  def set_best
    @answer = Answer.find(params[:answer_id])
    if current_user.author_of?(@answer.question)
      @answer.set_best
      respond_to do |format|
        format.html { redirect_to question_path(@answer.question),
          notice: 'Your answer successfully set best' }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to question_path(@answer.question),
          notice: 'You do not have permission to rate this answer' }
        format.js
      end
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
