module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: :vote
  end

  def vote
    respond_to do |format|
      unless current_user.author_of?(@votable)
        @votable.send("#{params[:vote]}_by", current_user)
        @vote = @votable.votes.where(user: current_user).first
        # format.html { render @votable, locals: { vote: @vote } }
        format.json { render json: { rating: @votable.rating, vote: @vote } }
      else
        format.html { redirect_to polymorphic_path(controller_name),
          notice: "You do not have permission to rate this #{controller_name.singularize}" }
      end
    end
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_klass.find(params[:id])
  end
end
