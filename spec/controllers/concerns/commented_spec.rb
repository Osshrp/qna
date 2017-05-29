require 'rails_helper'

shared_examples_for 'commented' do

  let(:resource) { controller.class.name.deconstantize.singularize.underscore.to_sym }
  let(:commentable) { create(resource) }
  let(:commentable_id) { "#{resource}_id".to_sym }
  let(:comment) { create(:comment, commentable: commentable) }
  let(:users_comment) { create(:comment, commentable: commentable, user: @user) }

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'associates comment with the user' do
        expect { post :create, params: { commentable_id => commentable,
                comment: attributes_for(:comment) }, format: :json }
                .to change(@user.comments, :count).by(1)
      end

      it 'associates comment with the commentable' do
        expect { post :create, params: { commentable_id => commentable,
                 comment: attributes_for(:comment) }, format: :json  }
                 .to change(commentable.comments, :count).by(1)
      end
    end
    context 'with invalid attributes' do
      it 'does not save the comment' do
        expect { post :create, params: { commentable_id => commentable,
          comment: attributes_for(:invalid_comment) }, format: :json }
          .to_not change(Comment, :count)
      end
    end
  end
end
