class Answer < ApplicationRecord
  include Attachable
  include Votable
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  def set_best
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end
end
