# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.best-answer-bage').closest('div').prependTo('.answers-list')

  App.cable.subscriptions.create('AnswersChannel', {
    connected: ->
      question_id = $(".question").data("id")
      @perform('follow', question_id: question_id)
    ,
    received: (data) ->
      json = $.parseJSON(data)
      answer= json.answer
      attachments = json.attachments
      question = json.question
      $('.answers-list').append(JST["answer"]({answer: answer, attachments: attachments, question: question}))
  })

# $(document).on('turbolinks:load', ready)
# $(document).on('turbolinks:visit', ready)
# $(document).ready(ready)
# $(document).on('ready', ready)
# $(window).load(ready)
# $(window).on('load', ready)
# $(document).on('page:load', ready)
# document.addEventListener("turbolinks:load", ready)
# $(document).on('click', '.question-link', ready)

$(document).on('click', '.edit-answer-link', (e) ->
  e.preventDefault()
  $(this).hide()
  answer_id = $(this).data('answerId')
  $('form#edit-answer-' + answer_id).show()
)
