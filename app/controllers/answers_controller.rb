class AnswersController < ApplicationController
  include Voted
  before_action :authenticate_user!
  before_action :set_answer, only: [:destroy, :update, :set_best]
  before_action :set_question, only: [:create]

  respond_to :js
  respond_to :json, only: :create

  authorize_resource

  def create
    respond_with(@answer = @question.answers.create(answer_params.merge(user: current_user)))
  end

  def update
    if current_user.author_of?(@answer)
      respond_with(@answer.update(answer_params))
    else
      redirect_to question_path(@answer.question),
        alert: 'You do not have permission to update this answer'
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      respond_with(@answer.destroy)
    else
      redirect_to question_path(@answer.question),
        alert: 'You do not have permission to delete this answer'
    end
  end

  def set_best
    if current_user.author_of?(@answer.question)
      @answer.set_best
    else
      redirect_to question_path(@answer.question),
        alert: 'You do not have permission to rate this answer'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :file, :_destroy])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
