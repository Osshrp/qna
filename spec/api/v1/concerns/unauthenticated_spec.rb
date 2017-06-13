require 'rails_helper'

shared_examples_for 'unauthenticated' do
  context 'unauthenticated' do
    it 'returns 401 status if there is no access_token' do
      get '/api/v1/profiles/me', as: :json
      expect(response.status).to eq 401
    end

    it 'returns 401 status if access_token is invalid' do
      get '/api/v1/profiles/me', as: :json, params: {access_token: '1234'}
      expect(response.status).to eq 401
    end
  end
end
