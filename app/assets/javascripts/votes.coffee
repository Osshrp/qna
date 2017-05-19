$(document).bind 'ajax:success', (e, data, status, xhr) ->
  json = $.parseJSON(xhr.responseText)
  votable = json.votable
  type = json.resource
  vote = json.vote
  if vote == null
    $('#vote-' + type + '-' + votable.id).html('')
    $('form#vote-' + type + '-' + votable.id).show()
    $('form#clear-vote-' + type + '-' + votable.id).hide()
  else
    console.log('vote: ', json.vote)
    $('#vote-' + type + '-' + votable.id).html("You've " + vote.value + "d it")
    $('form#vote-' + type + '-' + votable.id).hide()
    $('form#clear-vote-' + type + '-' + votable.id).show()
