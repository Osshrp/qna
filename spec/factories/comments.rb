FactoryGirl.define do
  factory :comment do
    commentable_type "MyString"
    commentable_id 1
    body "MyText"
    user nil
  end
end
