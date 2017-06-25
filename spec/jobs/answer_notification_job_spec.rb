require 'rails_helper'

RSpec.describe AnswerNotificationJob, type: :job do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  it 'should send email to author' do
    expect(AnswerMailer).to receive(:notify).with(question.user, answer).and_call_original
    AnswerNotificationJob.perform_now(answer)
  end
end
