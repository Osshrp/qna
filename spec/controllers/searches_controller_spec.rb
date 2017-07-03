require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  let(:question) { create(:question, title: '111') }

  before { get :show, params: { search: '111', resource: 'questions' } }
  describe 'GET #index' do
    it 'assigns resource to @resource' do
      expect(assigns(:resource)).to eq 'questions'
    end

    it 'assigns search to @search_string' do
      expect(assigns(:search_string)).to eq '111'
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
