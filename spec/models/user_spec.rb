require 'rails_helper'

RSpec.describe User do
  it { should have_many(:questions) }
  it { should have_many(:answers) }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  let(:user) { create(:user) }
  let(:user_with_questions) { create(:user_with_questions) }

  it 'should return true so as user is author of the entity' do
    expect(user_with_questions.author_of?(user_with_questions.questions.first)).to eq true
  end

  it 'should return false so as user is author of the entity' do
    expect(user.author_of?(user_with_questions.questions.first)).to eq false
  end
end
