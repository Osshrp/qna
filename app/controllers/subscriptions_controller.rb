class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: :create
  before_action :set_subscription, only: :destroy

  authorize_resource

  def create
    @subscription = @question.subscribe(current_user)
    respond_with(@subscription) do |format|
      format.html { redirect_to question_path(@question) }
    end
  end

  def destroy
    respond_with(@subscription.destroy) do |format|
      format.html { redirect_to question_path(@subscription.question) }
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
