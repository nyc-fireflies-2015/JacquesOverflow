$(document).ready(function(){
  $('#new_comment').on('submit',function(e){
    e.preventDefault();
    $.ajax({
      url: $(this).attr('action'),
      data: $(this).serialize(),
      method: $(this).attr('method')
    }).done(function(response){
      $(".question-comments-list").append(response);
    }).fail(function(response){
      console.log('something went wrong')
    })
  })

  $('#answer-comment-form').on('submit', function(e){
    e.preventDefault();
    $.ajax({
      url: $(this).attr('action'),
      data: $(this).serialize(),
      method: $(this).attr('method')
    }).done(function(response){
      $('#answer-comment-form').prepend(response);
    });
  })

  $('.new_answer').on('submit', function(e){
    e.preventDefault();
    // debugger
    $.ajax({
      url: $(this).attr('action'),
      data: $(this).serialize(),
      method: $(this).attr('method')
  }).done(function(response){
    debugger
    $('.new-answer').prepend(response);
  })
})
})