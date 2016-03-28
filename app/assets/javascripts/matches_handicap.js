$(document).ready(function(){
  
  $('#submitHandicap').click(function(event){
    event.preventDefault();
    event.stopPropagation();

    var votes = {
      "match_id": $('#rival0').attr('data-match'),
      "judge": $(this).attr('data-judge'),
      "rival0_id": $('#rival0').attr('data-rival'),
      "rival0_vote": $('#rival0').attr('data-vote'),
      "rival1_id": $('#rival1').attr('data-rival'),
      "rival1_vote": $('#rival1').attr('data-vote')
     };

    $.ajax({
      type: 'POST',
      url: "/matches/"+$('#rival0').attr('data-match')+"/rivals",
      data: votes,
      success: function(success){
        console.log("Updated ok")
      },
      dataType: 'json'
    });
    
    $('#handicapModal').modal('toggle');
  })




  $('.my-handicap').click(function(event){
    $('.modal-handicap-body').empty();
    $('.modal-handicap-body').append('<p>Puntúa a tus rivales según el NTRP (National Tennis Rating Program).La puntuación va del 1.0 al 7.0:</p>');

    var current_match = $(this).attr('data-match');

    var number=0;
    $('.rivals').each(function(i, riv){
      if (current_match === $(this).attr("data-player-match")){
        $('.modal-handicap-body').append('<p class="title" id="rival'+ number +'" data-rival="'+$(this).attr("data-rival")+'" data-vote="" data-match=""></p>');
        var html=""; 
        if ($(this).attr("vrival")==='false'){
        for (var j=2; j<13; j++){ 
              html += "<label class='btn btn-info'><input type='radio' name='options' id='option"+ j +"' autocomplete='off'> "+parseFloat(j/2)+"</label>";
            }
          }else
            html = '<p>YA votaste!! ;D</p>';
        $('.modal-handicap-body').append('<div class="btn-group group-rival'+ number +'" data-toggle="buttons">'+html+'</div>');

        $('#rival'+number).text($(this).attr("data-rival-name"));
        $('#rival'+number).attr('data-match', current_match);
        number += 1;
      }
    });

    $('.modal-handicap-body').append('<br><a data-dismiss="modal" data-toggle="modal" href="#lost">Instrucciones para la evaluación</a>');


    $(".group-rival0 .btn").click(function (event) {
    console.log(event.currentTarget.innerText);
      $('#rival0').attr('data-vote', event.currentTarget.innerText);
    });

    $(".group-rival1 .btn").click(function (event) {
      $('#rival1').attr('data-vote', event.currentTarget.innerText);
    });
   })





});

