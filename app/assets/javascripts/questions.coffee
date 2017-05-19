# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on('click', '.edit-question-link', (e) ->
  e.preventDefault();
  $(this).hide();
  $('form#edit-question').show();
)

$(document).on('click', '#question-update-submit', (e) ->
  $('form#edit-question').hide();
  $('.edit-question-link').show();
)

$(document).bind 'ajax:success', (e, data, status, xhr) ->
  question = $.parseJSON(xhr.responseText)
  if question.vote == null
    $('.like-badge').html('')
    $('.vote-form').show()
    $('.clear-vote-form').hide()
  else
    $('.like-badge').html("You've " + question.vote.value + " it")
    $('.vote-form').hide()
    $('.clear-vote-form').show()
