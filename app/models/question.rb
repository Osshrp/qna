class Question < ApplicationRecord
  include Attachable
  include Votable
  include Commentable
  has_many :answers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  belongs_to :user

  validates :title, :body, presence: true

  after_create :subscribe_author

  scope :daily, -> { where('created_at > ?', 1.day.ago) }

  def subscribe(user)
    subscriptions.create(user: user)
  end

  def unsubscribe(user)
    subscriptions.find_by(user: user).destroy
  end

  private

  def subscribe_author
    subscribe(user)
  end
end
