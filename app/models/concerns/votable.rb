module Votable
  extend ActiveSupport::Concern
  included do
    has_many :votes, as: :votable, dependent: :destroy

    accepts_nested_attributes_for :votes

  end

  def like_by(user)
    unless voted_by?(user)
      votes.create(value: "like", user: user)
      self.rating += 1
    end
  end

  def dislike_by(user)
    unless voted_by?(user)
      votes.create(value: "dislike", user: user)
      self.rating -= 1
    end
  end

  def clear_vote_by(user)
    if voted_by?(user)
      vote = votes.where(user: user).first
      vote.value == "like" ? self.rating -= 1 : self.rating += 1
      vote.destroy
    end
  end

  private

  def voted_by?(user)
    user.votes.exists?(votable_id: id, votable_type: self.class.name)
  end
end
