require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }
  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }
    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }
    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    sign_in_user
    before { get :edit, params: { id: question } }

    it 'assigns requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves new question in database' do
        expect { post :create, params: { question: attributes_for(:question) } }
          .to change(Question, :count).by(1)
      end

      it 'associates question with the user' do
        post :create, params: { question: attributes_for(:question) }
        expect(assigns(:question).user).to eq @user
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }
          .to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    context 'with valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(assigns(:question)).to eq question
      end

      it 'change question attributes' do
        patch :update, params: { id: question,
          question: { title: 'new_title', body: 'new_body' } }
        question.reload
        expect(question.title).to eq 'new_title'
        expect(question.body).to eq 'new_body'
      end

      it 'redirects to updated @question' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      let(:title) { question.title }
      let(:body) { question.body }
      before do
        patch :update, params: { id: question,
          question: { title: 'new_title', body: nil } }
      end
      it 'does not change @question attributes' do
        question.reload
        expect(question.title).to eq title
        expect(question.body).to eq body
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:users_question) do
      @user.questions.create(attributes_for(:question, user: @user))
    end
    before { question }

    it 'deletes question' do
      expect { delete :destroy, params: { id: users_question } }
        .to change(Question, :count).by(-1)
    end

    it 'redirects to index view' do
      delete :destroy, params: { id: users_question }
      expect(response).to redirect_to questions_path
    end

    it 'tries to delete question by another user' do
      expect { delete :destroy, params: { id: question } }
        .to change(Question, :count).by(0)
    end

    it 'redirects to questions index view' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end
end
