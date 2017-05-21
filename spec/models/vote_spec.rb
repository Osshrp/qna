require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:votable) }
  it { should belong_to(:user) }

  it { should validate_uniqueness_of(:value).scoped_to(:user_id, :votable_id, :votable_type) }

  describe '.show' do
    it 'should return like' do
      expect(Vote.show(1)).to eq :like
    end

    it 'should return dislike' do
      expect(Vote.show(-1)).to eq :dislike
    end
  end
end
