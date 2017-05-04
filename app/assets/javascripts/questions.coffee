# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    # answer_id = $(this).data('answerId');
    $('form#edit-question').show();
  $('#question-update-submit').click (e) ->
    $('form#edit-question').hide();
    $('.edit-question-link').show();
