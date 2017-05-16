module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: :set_vote
  end

  def set_vote
    unless current_user.author_of?(@votable)
      @votable.send("#{params[:vote]}_by", current_user)
    else
      redirect_to polymorphic_path(controller_name),
        notice: "You do not have permission to rate this #{controller_name.singularize}"
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
