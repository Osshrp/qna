require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:subscriptions).dependent(:destroy) }
  it { should belong_to(:user) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :attachments }

  it_behaves_like 'votable'

  let(:user) { create(:user) }
  let!(:question) { create(:question) }

  describe '#subscribe' do
    it 'should subscribe author after create question' do
      expect(question.subscriptions.first.user).to eq question.user
    end

    it 'should subscribe user to question' do
      expect{ question.subscribe(user) }.to change(question.subscriptions, :count).by(1)
    end
  end

  describe '#unsubscribe' do
    before { create(:subscription, question: question, user: user) }

    it 'should unsubscribe user to question' do
      expect{ question.unsubscribe(user) }.to change(question.subscriptions, :count).by(-1)
    end
  end
end
