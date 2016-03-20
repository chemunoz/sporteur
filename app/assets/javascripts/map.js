//MAPA
var map;

if ("geolocation" in navigator){
  navigator.geolocation.getCurrentPosition(onLocation, onError);
}


function onLocation(position){
  var myPosition = {
    lat: position.coords.latitude,
    lng: position.coords.longitude
  };
  createMap(myPosition);
  setupAutocomplete();
  
}

function onError(err){
  console.log("What are you using, IE 7??", err);
}

function createMap(position){
  console.log ("hola?");
  var mapOptions = {
    center: position,
    zoom: 17
  };
  map = new google.maps.Map($('#map')[0], mapOptions);
  createMarker(position);
}

function createMarker(position, description) {

  var marker = new google.maps.Marker({
   position: position,
   map: map
 });
 console.log(marker);
 var infowindow = new google.maps.InfoWindow({
    content: description
  });
 marker.addListener('click', function() {
    infowindow.open(map, marker);
  });
}

function setupAutocomplete(){
  var input = $('#get-places')[0];
  var autocomplete = new google.maps.places.Autocomplete(input);

  autocomplete.addListener('place_changed', function(){
   var place = autocomplete.getPlace();
   if (place.geometry.location) {
     map.setCenter(place.geometry.location);
     map.setZoom(17);
     //console.log(place.geometry.location);
     createMarker(place.geometry.location, place.formatted_address);
     saveLocations(place.geometry.location);
   } else {
     alert("The place has no location...?")
   }
 });
}


//createMarker({lat: 40.4425012, lng: -3.681632});
