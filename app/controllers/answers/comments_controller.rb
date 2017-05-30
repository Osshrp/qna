class Answers::CommentsController < CommentsController
  before_action :set_commentable, only: :create

  private

  def set_commentable
    @commentable = Answer.find(params[:answer_id])
    gon.commentable_name = 'answer'
  end
end
