require 'rails_helper'

shared_examples_for 'votable' do
  let(:model) { described_class }

  let(:user) { create(:user) }
  let(:votable) { create(model.to_s.underscore.to_sym) }

  describe '#like_by' do
    it 'should set like to votable' do
      votable.like_by(user)
      expect(Vote.last.value).to eq "like"
    end

    it 'should increase votables rating' do
      votable.like_by(user)
      expect(votable.rating).to eq 1
    end
  end

  describe '#dislike_by' do
    it 'should set dislike to votable' do
      votable.dislike_by(user)
      expect(Vote.last.value).to eq "dislike"
    end

    it 'should decrease votables rating' do
      votable.dislike_by(user)
      expect(votable.rating).to eq -1
    end
  end

  describe '#clear_vote_by' do
    it 'should clear users vote' do
      votable.dislike_by(user)
      expect { votable.clear_vote_by(user) }.to change(votable.votes, :count).by(-1)
    end
  end
end
