FactoryGirl.define do
  factory :answer do
    body 'AnswerText'
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    boly nil
  end
end
