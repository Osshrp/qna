class QuestionsController < ApplicationController
  include Voted
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :update, :destroy]

  after_action :publish_question, only: [:create]

  def index
    @questions = Question.all
  end

  def show
    @question_vote = @question.votes.where(user: current_user).first
    @answer = Answer.new
    @answer.attachments.build
    gon.current_user_id = current_user.id if current_user
  end

  def new
    @question = current_user.questions.new
    @question.attachments.build
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question, notice: 'Your question successfully created'
    else
      render :new
    end
  end

  def update
    if current_user.author_of?(@question)
      @question.update(question_params)
    else
      redirect_to questions_path,
        alert: 'You do not have permission to update this question'
    end
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      redirect_to questions_path, notice: 'Your question successfully deleted'
    else
      redirect_to questions_path,
        notice: 'You do not have permission to delete this question'
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(json: @question)
    )
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :file, :_destroy])
  end
end
