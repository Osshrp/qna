class AnswerNotificationJob < ApplicationJob
  queue_as :default

  def perform(answer)
    answer.question.subscriptions.each do |subscription|
      AnswerMailer.notify(subscription.user, answer).deliver_later
    end
  end
end
