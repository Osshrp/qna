class CommentsController < ApplicationController
  before_action :authenticate_user!

  respond_to :json, :js

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
    @comment = Comment.find(params[:id])
    if current_user.author_of?(@comment)
      respond_with @comment.destroy
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
