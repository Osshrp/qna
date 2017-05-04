require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should belong_to(:user) }
  it { should validate_presence_of :body }
  it { should have_db_index(:question_id) }

  let(:question) { create(:question_with_answers) }
  describe '#best' do
    it 'should set best answer' do
      answer = question.answers.first
      answer.set_best
      answer.reload
      expect(answer.best).to be_truthy
    end
  end
end
