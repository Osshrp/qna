require 'rails_helper'

RSpec.describe Questions::CommentsController, type: :controller do
  let(:question) { create(:question) }

  describe 'POST #create' do
    sign_in_user
    before { question }
    context 'with valid attributes' do

      it 'associates comment with the user' do
        expect { post :create, params: { question_id: question,
                 comment: attributes_for(:comment) }, format: :js }
          .to change(@user.comments, :count).by(1)
      end

      it 'associates comment with the question' do
        expect { post :create, params: { question_id: question,
                 comment: attributes_for(:comment) }, format: :js  }
          .to change(question.comments, :count).by(1)
      end
    end
  end
end
