class Answer < ApplicationRecord
  include Attachable
  include Votable
  include Commentable
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
    attaches = []
    attachments.each do |a|
      hash = { id: a.id, url: a.file.url, filename: a.file.identifier }
      attaches << hash
    end
    # ActionCable.server.broadcast(
    #   "question_#{question.id}_answers",
    #   ApplicationController.render(json: { question: question,
    #                                        answer: self,
    #                                        attachments: attaches })
      ApplicationController.render_with_serializer(user, json: { question: question,
                                                                 answer: self,
                                                                 attachments: attaches })
    # )
  end
end
