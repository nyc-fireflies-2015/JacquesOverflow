$(document).ready(function(){
  $('#new_comment').on('submit',function(e){
    e.preventDefault();
    $this = $(this);
    $.ajax({
      url: $this.attr('action'),
      data: $this.serialize(),
      method: 'POST'
    }).done(function(response){
      ('.question-comments-list').append(response)
    }).fail(function(){
      console.log("I failed")
    })
  })
})