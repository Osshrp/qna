$(document).bind 'ajax:success', (e, data, status, xhr) ->
  json = $.parseJSON(xhr.responseText)
  votable = json.votable
  type = json.resource
  vote = json.vote
  vote_value = json.vote_value
  console.log('object: ', '#vote-' + type + '-' + votable.id)
  console.log('type: ', type)
  console.log('vote: ', vote)
  console.log('vote_value: ', vote_value)
  if vote
    $('#vote-' + type + '-' + votable.id).html("You've " + vote_value + "d it")
    $('form#vote-' + type + '-' + votable.id).hide()
    $('form#clear-vote-' + type + '-' + votable.id).show()
  else
    $('#vote-' + type + '-' + votable.id).html('')
    $('form#vote-' + type + '-' + votable.id).show()
    $('form#clear-vote-' + type + '-' + votable.id).hide()
  $('#rate-' + type + '-' + votable.id).html(votable.rating)
