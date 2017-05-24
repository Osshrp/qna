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

$ ->
  App.cable.subscriptions.create('QuestionsChannel', {
    connected: ->
      @perform('follow')
    ,
    received: (data) ->
      json = $.parseJSON(data)
      question = json.question
      link = json.link
      li = "<li class='list-group-item'></li>"
      $('.questions-list').append(JST["question"]({question: question, url: link}))
  })
