require 'rails_helper'

shared_examples_for 'voted' do


  describe 'PATCH #set_vote' do
    sign_in_user
    let(:resource) { controller.controller_name.singularize.to_sym }
    let(:votable) { create(resource) }
    let(:users_votable) { create(resource, user: @user) }

    context 'user tries to like resource' do
      it 'set like to resource' do
        expect { patch :vote, params: { id: votable, vote: :like },
          format: :json }.to change(Vote, :count).by(1)
      end

      it 'increases rating by 1' do
        patch :vote, params: { id: votable, vote: :like }, format: :json
        votable.reload
        expect(votable.rating).to eq 1
      end
    end

    context 'user tries to dislike resource' do
      it 'set like to resource' do
        expect { patch :vote, params: { id: votable, vote: :dislike },
          format: :json }.to change(Vote, :count).by(1)
      end

      it 'decreases rating by 1' do
        patch :vote, params: { id: votable, vote: :dislike }, format: :json
        votable.reload
        expect(votable.rating).to eq -1
      end
    end

    context 'user tries to like resource once more time' do
      it 'set like to resource' do
        patch :vote, params: { id: votable, vote: :like }, format: :json
        expect { patch :vote, params: { id: votable, vote: :like },
          format: :json }.to_not change(Vote, :count)
      end

      it 'does not increases rating' do
        patch :vote, params: { id: votable, vote: :like }, format: :json
        patch :vote, params: { id: votable, vote: :like }, format: :json
        votable.reload
        expect(votable.rating).to eq 1
      end
    end

    context 'author tries to like his resource' do
      it 'does not set like to resource' do
        expect { patch :vote, params: { id: users_votable, vote: :like } }
          .to_not change(Vote, :count)
      end

      it 'does not increases rating' do
        patch :vote, params: { id: users_votable, vote: :like }
        votable.reload
        expect(votable.rating).to eq 0
      end
    end
  end
end
