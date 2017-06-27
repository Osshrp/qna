class AnswerMailer < ApplicationMailer
  def notify(user, answer)
    @question = answer.question
    @title = @question.title
    mail(to: user.email, subject: "New answer to #{@title}")
  end
end
