module Votable
  extend ActiveSupport::Concern
  included do
    has_many :votes, as: :votable, dependent: :destroy

    scope :test, ->(user, votable) { joins(:votes).where(user: user, votable_id: votable) }
  end

  def like_by(user)
    return if voted_by?(user)
    transaction do
      votes.create!(value: 1, user: user)
      self.rating += 1
      self.save!
    end
  end

  def dislike_by(user)
    return if voted_by?(user)
    transaction do
      votes.create!(value: -1, user: user)
      self.rating -= 1
      self.save!
    end
  end

  def clear_vote_by(user)
    if voted_by?(user)
      transaction do
        vote = votes.where(user: user).first
        vote.value == 1 ? self.rating -= 1 : self.rating += 1
        self.save!
        vote.destroy
      end
    end
  end

  def vote(user)
    votes.where(user: user).first if user
  end

  private

  def voted_by?(user)
    user.votes.exists?(votable_id: id, votable_type: self.class.name)
  end
end
