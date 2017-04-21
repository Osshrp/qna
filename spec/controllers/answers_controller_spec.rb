require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'GET #index' do
    let(:question) { create(:question_with_answers) }

    before { get :index, params: { question_id: question } }
    it 'populates an array of all answers' do
      expect(assigns(:question).answers).to match_array(question.answers)
    end
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end
