class Question < ApplicationRecord
  include Attachable
  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true
end
