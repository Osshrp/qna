require 'rails_helper'

describe '.execute' do

  let(:question) { create(:question, title: '111') }
  let!(:answer) { create(:answer, body: '111') }
  let!(:comment) { create(:comment, body: '111', commentable: question) }
  let!(:user) { create(:user, email: 'test@test.com') }
  let!(:query) { '111' }

  {questions: :title, answers: :body, comments: :body, users: :email}.each do |region, attr|
    it "should find object in #{region} and returns" do
      query = 'test@test.com' if :region == :users
      result = Search.execute(query.to_s, region.to_s).first
      byebug
      expect(result).to eq query
    end
  end
end
