require 'rails_helper'

describe 'Profile API' do
  describe 'GET me' do
    let(:headers) {{"CONTENT_TYPE" => "application/json"}}
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/profiles/me', headers: headers
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get '/api/v1/profiles/me', params: {access_token: '1234'}, headers: headers
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }

      it 'returns status 200' do
        get '/api/v1/profiles/me', params: {access_token: '1234'}, headers: headers
        expect(response.status).to be_success
      end
    end
  end
end
