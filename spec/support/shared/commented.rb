shared_examples_for 'commented' do

  let(:resource) { controller.class.name.deconstantize.singularize.underscore.to_sym }
  let(:commentable) { create(resource) }
  let(:commentable_id) { "#{resource}_id".to_sym }
  let(:comment) { create(:comment, commentable: commentable) }
  let(:users_comment) { create(:comment, commentable: commentable, user: @user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      sign_in_user
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

  context 'unauthenticated user tries to create comment' do
    it 'does not creates comment' do
      expect { post :create, params: { commentable_id => commentable,
               comment: attributes_for(:comment) }, format: :json  }
               .to change(commentable.comments, :count).by(0)
    end
  end

  describe 'DELETE #destroy' do
    context 'author user tries to delete comment' do
      sign_in_user
      it 'deletes comment' do
        users_comment
        expect { delete :destroy, params: { id: users_comment }, format: :js }
          .to change(Comment, :count).by(-1)
      end
    end
    context 'user tries to delete another_users comment' do
      sign_in_user
      it ' does not delete comment' do
        comment
        expect { delete :destroy, params: { id: comment }, format: :js }
          .to change(Comment, :count).by(0)
      end
    end

    context 'guest tries to delete comment' do
      it ' does not delete comment' do
        comment
        expect { delete :destroy, params: { id: comment }, format: :js }
          .to change(Comment, :count).by(0)
      end
    end
  end
end
