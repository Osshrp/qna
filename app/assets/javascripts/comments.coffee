# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  App.cable.subscriptions.create('CommentablesCommentsChannel', {
    connected: ->
      commentable_id = $(".question").data("id")
      @perform('follow', commentable_name: "question", commentable_id: commentable_id)

    received: (data) ->
      json = $.parseJSON(data)
      comment= json.comment
      commentable = json.commentable
      commentable_name = json.commentable_name
      $('.' + commentable_name + '-' + commentable.id + '-comments-list')
        .append(JST["comment"]({commentable: commentable, comment: comment}))
  })

$(document).on('click', '.new-question-comment-link', (e) ->
  e.preventDefault();
  $(this).hide();
  $('form#question-comment').show();
)
