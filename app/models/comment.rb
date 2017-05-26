class Comment < ApplicationRecord
  belongs_to :commentable, optional: true, polymorphic: true
  belongs_to :user

  validates :body, presence: true
end
