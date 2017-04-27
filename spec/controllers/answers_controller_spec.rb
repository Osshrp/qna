require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }

  describe 'GET #show' do
    before { get :show, params: { id: answer } }

    it 'assigns requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    sign_in_user
    before { question }
    context 'with valid attributes' do
      it 'saves new answer in database' do
        expect { post :create, params: { question_id: question,
                                         answer: attributes_for(:answer) } }
          .to change(Answer, :count).by(1)
      end

      it 'associates answer with the user' do
        expect { post :create, params: { question_id: question,
                                answer: attributes_for(:answer) } }
          .to change(@user.answers, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question_id: question,
                                answer: attributes_for(:answer) }
        expect(response).to redirect_to answer_path(assigns(:answer))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { question_id: question,
                                         answer: attributes_for(:invalid_answer) } }
          .to_not change(Answer, :count)
      end

      it 'redirects to question show view' do
        post :create, params: { question_id: question,
                                answer: attributes_for(:invalid_answer) }
        expect(response).to render_template('questions/show')
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:users_answer) do
      @user.answers.create(attributes_for(:answer, user: @user,
                                            question_id: question.id))
    end

    before { answer }

    context 'author tries to delete answer' do
      it 'deletes answer' do
        expect { delete :destroy, params: { id: users_answer } }
          .to change(Answer, :count).by(-1)
      end

      it 'redirects to question show view' do
        delete :destroy, params: { id: users_answer }
        expect(response).to redirect_to question_path(users_answer.question)
      end
    end

    context 'user tries to deletes answer that does not belongs to him' do
      it 'does not deletes answer' do
        expect { delete :destroy, params: { id: answer } }
          .to_not change(Answer, :count)
      end

      it 'redirects to questions index view' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to questions_path
      end
    end
  end
end
