class AnswerMailer < ApplicationMailer
  def notify(user, answer)
    @greeting = "Hi"
    @answer = answer
    @user = user
    mail(to: @user.email, subject: "New answer to #{answer.question.title}")
  end
end
