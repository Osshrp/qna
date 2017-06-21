class DailyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.daily_mailer.digest.subject
  #
  def digest(user, questions)
    @greeting = "Hi"
    @questions = questions
    @user = user
    mail(to: @user.email, subject: 'Daily digest')
  end
end
