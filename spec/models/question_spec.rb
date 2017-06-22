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

  describe '#subscribe' do
    let(:user) { create(:user) }
    it 'should subscribe user to question' do
      subject.subscribe(subject.user)
      expect(subject.subscriptions.first.user).to eq user
    end
  end
end
