$ ->
  App.cable.subscriptions.create('AnswersCommentsChannel', {
    connected: ->
      subscriptions = this
      $('.answer').each ->
        subscriptions.perform 'follow',
          commentable_name: 'answer',
          commentable_id: $(this).attr('data-id')

    received: (data) ->
      json = $.parseJSON(data)
      comment = json.comment
      commentable = json.commentable
      commentable_name = json.commentable_name
      delete_link = '/comments/' + comment.id
      $('.' + commentable_name + '-' + commentable.id + '-comments-list').append JST['comment'](
        commentable: commentable
        comment: comment
        delete_link: delete_link
        resource: 'answer')
      $('form#answer-' + commentable.id + '-comment').toggle()
      $('#answer-' + commentable.id + '-comment-link').toggle()
    })

$(document).on('click', '.new-answer-comment-link', (e) ->
  e.preventDefault();
  answer_id = $(this).attr('data-answer-id')
  $(this).toggle();
  $('form#answer-' + answer_id + '-comment').toggle();
)
