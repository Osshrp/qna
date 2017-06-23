class AnswerNotificationJob < ApplicationJob
  queue_as :default

  def perform(answer)
    answer.question.subscriptions.each do |subscription|
      AnswerMailer.notify(subscription.user, answer).deliver_later(wait: 1.minute)
    end
  end
end
