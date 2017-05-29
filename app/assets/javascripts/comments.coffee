# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  App.cable.subscriptions.create('QuestionsCommentsChannel', {
    connected: ->
      question_id = $(".question").data("id")
      @perform('follow', question_id: question_id)

    received: (data) ->
      json = $.parseJSON(data)
      comment= json.comment
      commentable = json.commentable
      $('.question-' + commentable.id + '-comments-list').append(JST["comments"]({commentable: commentable, comment: comment}))
  })

$(document).on('click', '.new-question-comment-link', (e) ->
  e.preventDefault();
  $(this).hide();
  $('form#question-comment').show();
)
