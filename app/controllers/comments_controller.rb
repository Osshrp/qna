class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: :destroy

  respond_to :json, :js

  authorize_resource

  def create
    @comment = @commentable.comments.new(comment_params.merge(user: current_user))
    gon.commentabel_id = @commentable.id
    respond_to do |format|
      if @comment.save
        format.json { render json: { comment: @comment, commentable: @commentable } }
      else
        format.json { render json: @comment.errors.full_messages, status: :unprocessable_entity  }
      end
    end
  end

  def destroy
    respond_with @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
