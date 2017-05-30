$ ->
  commentsSubscription("answer");

$(document).on('click', '.new-answer-comment-link', (e) ->
  e.preventDefault();
  answer_id = $(this).attr('data-answer-id')
  $(this).hide();
  console.log('form: ', this)
  $('form#answer-' + answer_id + '-comment').show();
)
