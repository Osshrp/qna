class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  def set_best
    clear_best
    update(best: true)
  end

  private

  def clear_best
    question.answers.where(best: true).each do |answer|
      answer.update(best: false)
    end
  end
end
