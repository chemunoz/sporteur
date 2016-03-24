var map;
var markersArray = [];

function checkEnter(e){
  e = e || event;
  var txtArea = /textarea/i.test((e.target || e.srcElement).tagName);
  return txtArea || (e.keyCode || e.which || e.charCode || 0) !== 13;
}


function initMap(){

  //NEW View
  if ($('.new_map').length>0){
    var myPosition = {
      lat: 40.4382915,
      lng: -3.6836605
    };
    zoom=8;
    createMap(myPosition, zoom);
    setupAutocomplete();
  }

  //SHOW View
  if ($('.show_map').length>0){
    var lati = document.getElementsByClassName('lat');
    var long = document.getElementsByClassName('lng');
    var venues = document.getElementsByClassName('venue');

    //Map
    if (lati.length>1){
      zoom=8;
      createMap({lat: 40.4260577,lng: -3.7556513}, zoom);
    }else{
      zoom=12;
      createMap({lat: parseFloat(lati[0].innerText),lng: parseFloat(long[0].innerText)}, zoom);
    }

    for (var i=lati.length-1; i>=0; i--){  
      isNaN(parseFloat(lati[i].innerText)) ? latitud=40.4260577 : latitud=parseFloat(lati[i].innerText)
      isNaN(parseFloat(long[i].innerText)) ? longitud=-3.7556513 : longitud=parseFloat(long[i].innerText)

      var myPosition = {
        lat: latitud,
        lng: longitud
      };

      //Markers
      createMarker(myPosition, venues[i].innerText);  
      }
    };
};


function createMap(position, zoom){
  var mapOptions = {
    center: position, //Madrid{lat: 40.4260577, lng: -3.7556513},
    zoom: zoom,
    
  };
  map = new google.maps.Map($('#map')[0], mapOptions);
}


function createMarker(position, description) {
  if ($('.new_map').length>0){
    clearMarkers();
  }

  var marker = new google.maps.Marker({
   position: position,
   map: map
  });
  markersArray.push(marker);

  if ($('.new_map').length>0){
    $('#lat_form').val(marker.position.lat());
    $('#lng_form').val(marker.position.lng());
  }
  
  //letters  
  var infowindow = new google.maps.InfoWindow({
    content: description
  });
  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });
}

function clearMarkers() {
  for (var i = 0; i < markersArray.length; i++ ) {
    markersArray[i].setMap(null);
  }
  markersArray.length = 0;
}


function setupAutocomplete(){
  var input = $('#venue')[0];
  var autocomplete = new google.maps.places.Autocomplete(input);

  autocomplete.addListener('place_changed', function(){
   var place = autocomplete.getPlace();
   if (place.geometry.location) {
     map.setCenter(place.geometry.location);
     map.setZoom(17);
     createMarker(place.geometry.location, place.formatted_address);
   } else {
     alert("The place has no location...?")
   }
 });
}




$(document).on("ready", function(){
  if ($('.new_map').length>0){
    document.querySelector('form').onkeypress = checkEnter;
  }
  initMap();
});







//createMarker({lat: 40.4425012, lng: -3.681632});
