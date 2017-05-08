class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :attachments, dependent: :destroy, as: :attachmentable
  belongs_to :user

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments
end
