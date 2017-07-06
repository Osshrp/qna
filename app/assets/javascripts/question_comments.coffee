# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  App.cable.subscriptions.create('QuestionsCommentsChannel', {
    connected: ->
      question_id = $(".question").data("id")
      @perform('follow', commentable_name: 'question', commentable_id: question_id)
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
        resource: 'question')
      $('form#question-' + commentable.id + '-comment').toggle()
      $('#question-' + commentable.id + '-comment-link').toggle()
    })

$(document).on('click', '.new-question-comment-link', (e) ->
  e.preventDefault();
  question_id = $(this).attr('data-question-id')
  $(this).toggle();
  $('form#question-' + question_id + '-comment').toggle();
)
