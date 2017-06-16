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
            to be_json_eql(answers.last.send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
        end
      end
    end
  end

  describe 'GET /show' do
    let(:answer) { create(:answer, question: question) }
    let!(:comment) { create(:comment, commentable: answer) }

    context 'unauthenticated' do
      it 'returns 401 status if there is no access_token' do
        get api_v1_answer_path(answer), as: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get api_v1_answer_path(answer),
          as: :json, params: {access_token: '1234'}
        expect(response.status).to eq 401
      end
    end

    context 'authenticated' do
      let(:access_token) { create(:access_token) }
      before do
        file = File.open("#{Rails.root}/spec/spec_helper.rb")
        answer.attachments.create(file: file)
      end
      before { get api_v1_answer_path(answer),
        as: :json, params: {access_token: access_token.token} }

      it 'returns 200 status code' do
        expect(response).to be_success
      end

      %w(id body created_at updated_at rating).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).
            to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answer/#{attr}")
        end
      end

      context 'comments' do
        it 'included in answer object' do
          expect(response.body).to have_json_size(1).at_path("answer/comments")
        end

        %w(id body created_at updated_at).each do |attr|
          it "contains #{attr}" do
            expect(response.body).
              to be_json_eql(comment.send(attr.to_sym).to_json).
                at_path("answer/comments/0/#{attr}")
          end
        end
      end

      context 'attachments' do


        it 'included in answer object' do
          expect(response.body).to have_json_size(1).at_path("answer/attachments")
        end

        it 'contains url' do
          expect(response.body).
            to be_json_eql(answer.attachments.first.file.url.to_json).
              at_path('answer/attachments/0/url')
        end
      end
    end
  end
end
