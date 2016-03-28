$(document).on("ready", function(){
  if ($('.profile-container').length>0){
    var chart = c3.generate({
        data: {
            // iris data from R
            columns: [
                ['Wins', parseInt($('#match_win')[0].innerText)],
                ['Loses', parseInt($('#match_lose')[0].innerText)],
            ],
            type : 'pie',
            onclick: function (d, i) { console.log("onclick", d, i); },
            onmouseover: function (d, i) { console.log("onmouseover", d, i); },
            onmouseout: function (d, i) { console.log("onmouseout", d, i); }
        }
    });
  }
});


