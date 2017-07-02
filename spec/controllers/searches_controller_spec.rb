require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  let(:question) { create(:question, title: '111') }

  before { get :show, params: { search: '111', scope: 'questions' } }
  describe 'GET #index' do
    it 'assigns region to @region' do
      expect(assigns(:region)).to eq 'questions'
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
