$(document).ready(function(){
  $('#new_comment').on('submit',function(e){
    e.preventDefault();
    $this = $(this);
    // debugger
    $.ajax({
      url: $this.attr('action'),
      data: $this.serialize(),
      method: $this.attr('method')
    }).done(function(response){
      $(".question-comments-list").append(response);
    }).fail(function(response){
      console.log(response)
    })
  })

  $('#new_answer').on('submit')

})