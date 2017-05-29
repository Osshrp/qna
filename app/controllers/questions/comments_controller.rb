class Questions::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Question.find(params[:question_id])
    gon.commentable_name = 'question'
  end
end
