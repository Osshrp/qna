class Comment < ApplicationRecord
  belongs_to :commentable, optional: true, polymorphic: true, touch: true
  belongs_to :user

  validates :body, presence: true

  after_create :publish_comment

  private

  def publish_comment
    commentable_name = commentable_type.underscore
    ActionCable.server.broadcast(
      "#{commentable_name}_#{commentable.id}_comments",
      ApplicationController.render_with_serializer(user, json: { commentable: commentable,
                                                                 commentable_name: commentable_name,
                                                                 comment: self })
    )
  end
end
