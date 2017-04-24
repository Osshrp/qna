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
    before { question }
    context 'with valid attributes' do
      it 'saves new answer in database' do
        expect { post :create, params: {
                                         question_id: question,
                                         answer: attributes_for(:answer) } }
          .to change(Answer, :count).by(1)
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

      it 're-renders new view' do
        post :create, params: { question_id: question,
                                answer: attributes_for(:invalid_answer) }
        expect(response).to render_template :new
      end
    end
  end
end
