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
    respond_with(@answer.update(answer_params))
  end

  def destroy
    respond_with(@answer.destroy)
  end

  def set_best
    @answer.set_best
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
