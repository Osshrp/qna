class QuestionsCommentsChannel< ApplicationCable::Channel
  def follow(data)
    stream_from("question_#{data["question_id"]}_comments")
  end
end
