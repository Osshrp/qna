class Answer < ApplicationRecord
  include Attachable
  belongs_to :question

  validates :body, presence: true

  def set_best
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end
end
