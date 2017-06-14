class QuestionSerializer < ActiveModel::Serializer
  # attributes :id, :title, :body, :created_at, :updated_at
  attributes :id, :title
  has_many :answers
end
