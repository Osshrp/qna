FactoryGirl.define do
  sequence :body do |n|
    "AnswerText#{n}"
  end

  factory :answer do
    body
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    boly nil
  end
end
