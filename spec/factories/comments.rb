FactoryGirl.define do
  factory :comment do
    commentable_type "MyString"
    commentable_id 1
    body "MyText"
    user
  end

  factory :invalid_comment, class: 'Comment' do
    boly nil
  end
end
