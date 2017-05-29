# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  App.cable.subscriptions.create('CommentsChannel', {
    connected: ->
      @perform('follow', commentable_name: gon.commentable_name commentable_id: gon.commentable_id )

    received: (data) ->
      json = $.parseJSON(data)
      comment= json.comment
      commentable = json.commentable
      $('.' + gon.commentable_name + '-' + gon.commentable_id + '-comments-list').append(JST["comments"]({commentable: commentable, comment: comment}))
  })

$(document).on('click', '.new-question-comment-link', (e) ->
  e.preventDefault();
  $(this).hide();
  $('form#question-comment').show();
)
