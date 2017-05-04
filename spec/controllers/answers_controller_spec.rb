require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'POST #create' do
    sign_in_user
    before { question }
    context 'with valid attributes' do

      it 'associates answer with the user' do
        expect { post :create, params: { question_id: question,
                 answer: attributes_for(:answer) }, format: :js }
          .to change(@user.answers, :count).by(1)
      end

      it 'associates answer with the question' do
        expect { post :create, params: { question_id: question,
                 answer: attributes_for(:answer) }, format: :js  }
          .to change(question.answers, :count).by(1)
      end

      it 'renders create template' do
        post :create, params: { question_id: question,
                                answer: attributes_for(:answer) }, format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { question_id: question,
                 answer: attributes_for(:invalid_answer) }, format: :js }
          .to_not change(Answer, :count)
      end

      it 'renders to question show view' do
        post :create, params: { question_id: question,
                                answer: attributes_for(:invalid_answer) }, format: :js
        expect(response).to render_template('answers/create')
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:users_answer) { create(:answer, user: @user, question_id: question.id) }

    before { answer }

    context 'author tries to delete answer' do
      it 'deletes answer with js' do
        expect { delete :destroy, params: { id: users_answer }, format: :js }
          .to change(Answer, :count).by(-1)
      end

      it 'deletes answer without js' do
        expect { delete :destroy, params: { id: users_answer } }
          .to change(Answer, :count).by(-1)
      end

      it 'redirects to question show view when delete without js' do
        delete :destroy, params: { id: users_answer }
        expect(response).to redirect_to question_path(users_answer.question)
      end

      it 'renders question destroy view when delete with js' do
        delete :destroy, params: { id: users_answer }, format: :js
        expect(response).to render_template :destroy
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

  describe 'PATCH #update' do
    sign_in_user
    let!(:users_answer) { create(:answer, user: @user, question_id: question.id) }

    context 'author tries to update answer' do
      it 'assigns the requested answer to @answer' do
        patch :update, params: { question_id: question, id: users_answer,
          answer: attributes_for(:answer) }, format: :js
        expect(assigns(:answer)).to eq users_answer
      end

      it 'change answer attributes' do
        patch :update, params: { question_id: question, id: users_answer,
          answer: { body: 'new_body' } }, format: :js
        users_answer.reload
        expect(users_answer.body).to eq 'new_body'
      end

      it 'renders update template' do
        patch :update, params: { question_id: question, id: users_answer,
          answer: attributes_for(:answer) }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'another user tries to update answer that does not belongs to him' do
      it 'does not change answer attributes' do
        answer_body = answer.body
        patch :update, params: { question_id: question, id: answer,
          answer: { body: 'new_body' } }, format: :js
        answer.reload
        expect(answer.body).to eq answer_body
      end
    end
  end

  describe 'POST #set_best' do
    sign_in_user

    context 'author of question tries to set best flag to answer' do
      let!(:users_question) { create(:question_with_answers, user: @user) }
      it 'set best flag to answer' do
        post :set_best, params: { answer_id: users_question.answers.first }, format: :js
        expect(assigns(:answer).best).to eq true
      end

      it 'set best flag to answer without js' do
        post :set_best, params: { answer_id: users_question.answers.first }
        expect(assigns(:answer).best).to eq true
      end
    end

    context 'another user tries to set best flag to answer' do
      let(:question) { create(:question_with_answers) }
      it 'should not set best flag to answer' do
        post :set_best, params: { answer_id: question.answers.first }, format: :js
        expect(assigns(:answer).best).to eq false
      end

      it 'should not set best flag to answer without js' do
        post :set_best, params: { answer_id: question.answers.first }
        expect(assigns(:answer).best).to eq false
      end
    end

    context 'unauthenticated user tries to set best flag to answer' do
      let(:question) { create(:question_with_answers) }
      it 'should not set best flag to answer' do
        sign_out(@user)
        post :set_best, params: { answer_id: question.answers.first }, format: :js
        expect(question.answers.first.best).to eq false
      end

      it 'should not set best flag to answer without js' do
        sign_out(@user)
        post :set_best, params: { answer_id: question.answers.first }
        expect(question.answers.first.best).to eq false
      end
    end
  end
end
