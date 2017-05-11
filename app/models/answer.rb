class Answer < ApplicationRecord
  has_many :attachments, as: :attachmentable, dependent: :destroy
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  def set_best
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end
end
