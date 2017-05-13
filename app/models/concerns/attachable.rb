module Attachable
  extend ActiveSupport::Concern
  included do
    has_many :attachments, as: :attachable, dependent: :destroy
    belongs_to :user

    accepts_nested_attributes_for :attachments, reject_if: :all_blank
  end
end
