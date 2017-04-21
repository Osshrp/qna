FactoryGirl.define do
  factory :answer do
    body 'MyText'
    question
  end

  factory :invalid_answer, class: 'Answer' do
    boly nil
  end
end
