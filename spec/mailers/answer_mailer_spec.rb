require "rails_helper"

RSpec.describe AnswerMailer, type: :mailer do
  describe "digest" do
    let(:user)  { create(:user) }
    let(:answer) { create(:answer) }
    let(:mail) { AnswerMailer.notify(user, answer) }

    it "renders the headers" do
      expect(mail.subject).to eq("New answer to #{answer.question.title}")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end
end
