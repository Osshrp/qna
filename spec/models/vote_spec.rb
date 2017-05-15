require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:votable) }
  it { should belong_to(:user) }

  it { should validate_uniqueness_of(:is_liked).scoped_to(:user_id, :votable_id, :votable_type) }

  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }
  describe '#like' do
    it 'should set like to question' do
      question.like_by(user)
      expect(Vote.last.is_liked).to be_truthy
    end

    it 'should set like to answer' do
      answer.like_by(user)
      expect(Vote.last.is_liked).to be_truthy
    end
  end
end
