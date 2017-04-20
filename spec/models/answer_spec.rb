require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) { Question.create(title: '123', body: '123') }
  let(:answer) { Answer.create(body: '123', question: question) }

  it { should validate_presence_of :body }
  it { should belong_to(:question) }
  it { should have_db_index(:question_id) }

  it 'check_presence_of_question_id' do
    answer.question_id.should equal(question.id)
  end
end
