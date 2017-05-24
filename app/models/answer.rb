class Answer < ApplicationRecord
  include Attachable
  include Votable
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  after_create :publish_answer

  def set_best
    transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end

  private

  def publish_answer
    ActionCable.server.broadcast(
      "question_#{question.id}_answers",
      ApplicationController.render(json: { question: question,
                                           answer: self })
    )
  end
end
