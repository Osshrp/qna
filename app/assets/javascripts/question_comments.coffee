# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  commentsSubscription("question");

$(document).on('click', '.new-question-comment-link', (e) ->
  e.preventDefault();
  question_id = $(this).attr('data-question-id')
  $(this).toggle();
  $('form#question-' + question_id + '-comment').toggle();
)
