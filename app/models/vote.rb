class Vote < ApplicationRecord
  belongs_to :votable, optional: true, polymorphic: true
  belongs_to :user

  validates :is_liked, uniqueness: { scope: [:user_id, :votable_id, :votable_type] }
end
