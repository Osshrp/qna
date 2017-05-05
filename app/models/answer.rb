class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  def set_best
    question.answers.where(best: true).each do |answer|
      answer.update(best: false)
    end
    update(best: true)
  end
end
