class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, :body, presence: true

  def best_answer(answer)
    clear_best_answer
    answer.best = true
    answer.save
  end

  private

  def clear_best_answer
    answers.where(best: true).each do |answer|
      answer.best = false
      answer.save
    end
  end
end
