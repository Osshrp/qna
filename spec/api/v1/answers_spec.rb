require 'rails_helper'

describe 'Answers API' do
  let(:question) { create(:question) }
  describe 'GET /index' do
    context 'unauthenticated' do
      it 'returns 401 status if there is no access_token' do
        get api_v1_question_answers_path(question), as: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get api_v1_question_answers_path(question), as: :json, params: {access_token: '1234'}
        expect(response.status).to eq 401
      end
    end

    context 'authenticated' do
      let!(:answers) { create_list(:answer, 2, question: question) }
      let(:access_token) { create(:access_token) }
      before { get api_v1_question_answers_path(question), as: :json, params: {access_token: access_token.token} }

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      it 'returns list of answers' do
        expect(response.body).to have_json_size(2).at_path("answers")
      end

      %w(id body created_at updated_at rating).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).
            to be_json_eql(answers.first.send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
        end
      end
    end
  end
end
