require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should belong_to(:user) }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  let(:question) { create(:question_with_answers) }
  describe '#best_answer' do
    it 'should set best answer' do
      answer = question.answers.first
      question.best_answer(answer)
      answer.reload
      expect(answer.best).to be_truthy
    end
  end
end
