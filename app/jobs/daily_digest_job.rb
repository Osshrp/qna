class DailyDigestJob < ApplicationJob
  queue_as :default

  def perform
    questions = Question.where('created_at > ?', 1.day.ago)
    if questions.present?
      User.find_each do |user|
        DailyMailer.digest(user, questions.to_a).deliver_later
      end
    end
  end
end
