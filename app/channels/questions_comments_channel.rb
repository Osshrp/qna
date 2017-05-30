class QuestionsCommentsChannel< ApplicationCable::Channel
  def follow(data)
    stream_from("#{data["commentable_name"]}_#{data["commentable_id"]}_comments")
  end
end
