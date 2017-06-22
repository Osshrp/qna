require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should belong_to(:user) }
  it { should have_many :attachments }
  it { should have_many(:comments).dependent(:destroy) }
  it { should validate_presence_of :body }
  it { should accept_nested_attributes_for :attachments }

  let(:question) { create(:question_with_answers) }
  let(:answer) { question.answers.first }
  let(:new_best_answer) { question.answers.last }

  it_behaves_like 'votable'

  describe '#set_best' do
    before do
      answer.set_best
    end
    it 'should set best answer' do
      answer.reload
      expect(answer.best).to be_truthy
    end

    it 'should remove best mark from old best answer' do
      new_best_answer.set_best
      answer.reload
      expect(answer.best).to be_falsey
    end
  end

  describe '#send_email' do
    let(:question) { create(:question) }

    it 'should send email to author after create answer' do
      expect(AnswerMailer).to receive(:notify).with(instance_of(Answer)).and_call_original
      question.answers.create(body: 'body', user: question.user)
    end
  end
end
