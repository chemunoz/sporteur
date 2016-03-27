$(document).ready(function(){
  
  $('#submitScore').click(function(event){
    event.preventDefault();
    event.stopPropagation();

    var sets = {
      "game1-local": $('[name=games1-local]').val(),
      "game1-visit": $('[name=games1-visit]').val(),
      "game2-local": $('[name=games2-local]').val(),
      "game2-visit": $('[name=games2-visit]').val(),
      "game3-local": $('[name=games3-local]').val(),
      "game3-visit": $('[name=games3-visit]').val(),
      "game4-local": $('[name=games4-local]').val(),
      "game4-visit": $('[name=games4-visit]').val(),
      "game5-local": $('[name=games5-local]').val(),
      "game5-visit": $('[name=games5-visit]').val()
    };
    
    $.ajax({
      type: 'PATCH',
      url: "/matches/"+$('.btn-score').data("match"),
      data: sets,
      success: function(success){
        console.log("Updated ok")
      },
      dataType: 'json'
    });
    $('#scoreModal').modal('toggle');
  })



  $('.my-score').click(function(event){
    
    var match = $(event.currentTarget).data("match");
    var score = $('#score'+match)[0].innerText;
    // 6-2 2-6 7-5 - -
    $('[name="games1-local"]').val(score[0]);
    $('[name="games1-visit"]').val(score[2]);
    $('[name="games2-local"]').val(score[4]);
    $('[name="games2-visit"]').val(score[6]);
    $('[name="games3-local"]').val(score[8]);
    $('[name="games3-visit"]').val(score[10]);
    $('[name="games4-local"]').val(score[12]);
    $('[name="games4-visit"]').val(score[14]);
    $('[name="games5-local"]').val(score[16]);
    $('[name="games5-visit"]').val(score[18]);
  })


});