module Votable
  extend ActiveSupport::Concern
  included do
    has_many :votes, as: :votable, dependent: :destroy

    accepts_nested_attributes_for :votes

  end

  def liked_by(user)
    vote.update(is_liked: true) if vote.is_liked.blank?
  end

  def disliked_by(user)
    vote.update(is_liked: false) if vote.is_liked.blank?
  end

  def clear_vote_by(user)
    vote.update(is_liked: nil) if vote.is_liked.present?
  end

  private

  def vote
    votes.where(user: user).first
  end
end
