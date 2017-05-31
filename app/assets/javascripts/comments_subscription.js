var commentsSubscription = function(resource) {
  capitalized_resource = resource.substr(0,1).toUpperCase()+resource.substr(1);
  App.cable.subscriptions.create(capitalized_resource + 'sCommentsChannel', {
    connected: function() {
      var subscriptions = this
      $('.' + resource).each(function() {
        return subscriptions.perform('follow', {
          commentable_name: resource,
          commentable_id: $(this).attr('data-id')
        });
      })
    },
    received: function(data) {
      var comment, commentable, commentable_name, delete_link, json;
      json = $.parseJSON(data);
      comment = json.comment;
      commentable = json.commentable;
      commentable_name = json.commentable_name;
      delete_link = '/' + commentable_name + 's/' + commentable.id + '/comments/' + comment.id;
      $('.' + commentable_name + '-' + commentable.id + '-comments-list').append(JST["comment"]({
        commentable: commentable,
        comment: comment,
        delete_link: delete_link,
        resource: resource
      }));
      $('form#' + resource + '-' + commentable.id + '-comment').toggle();
      $('#' + resource + '-' + commentable.id + '-comment-link').toggle();
    }
  });
};
