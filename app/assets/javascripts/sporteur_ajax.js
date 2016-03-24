// function call_Ajax(method, uri, success_callback){
//   console.log(method);
//   console.log(uri);
//   console.log(success_callback);

//   $.ajax({
//     type: method,
//     url: uri,
//     success: success_callback,
//     //dataType: 'json'
//   });
// }

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
      url: "/matches/"+$('.btn-score').data("equip"),
      data: sets,
      success: function(success){
        console.log("Updated ok")
      },
      dataType: 'json'
    });
    $('#myModal').modal(toggle);
  })
});