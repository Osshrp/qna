module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: :vote
  end

  def vote
    respond_to do |format|
      if current_user.author_of?(@votable)
        format.html { redirect_to questions_path,
          notice: "You do not have permission to rate this #{controller_name.singularize}" }
      else
        change_vote
        @vote = @votable.votes.where(user: current_user).first
        format.json { render json: { resource: controller_name.singularize ,
                                     votable: @votable,
                                     vote: @vote,
                                     vote_value: @vote&.show_value } }
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

  def change_vote
    vote = { "like" => :like_by, "dislike" => :dislike_by, "clear_vote" => :clear_vote_by }
    @votable.send(vote[params[:vote]], current_user) if vote.has_key?(params[:vote])
  end
end
