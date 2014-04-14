var map;
var service;
var marker;
var pos;
var infowindow;
var results = [];

function initialize() {

  var mapOptions = {
    zoom: 15
  };

  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  // Try HTML5 geolocation
  if (navigator.geolocation) {

    navigator.geolocation.getCurrentPosition(function(position) {
      pos = new google.maps.LatLng(position.coords.latitude,
        position.coords.longitude);
        window.longi = position.coords.longitude;
        window.lati = position.coords.latitude;
      infowindow = new google.maps.InfoWindow({
        map: map,
        position: pos,
        content: 'You Are Here.'
      });

      map.setCenter(pos);

      var request = {
        location: pos,
        radius: 20000,
        types: ['park']
      };

      infowindow = new google.maps.InfoWindow();
      var service = new google.maps.places.PlacesService(map);
      service.nearbySearch(request, callback);
    }, function() {
      handleNoGeolocation(true);
    });
  } else {
    // Browser doesn't support Geolocation
    handleNoGeolocation(false);
  }

  google.maps.event.addDomListener(window, "resize", function() {
   var center = map.getCenter();
   google.maps.event.trigger(map, "resize");
   map.setCenter(center);
  });

  function callback(results, status) {
    if (status == google.maps.places.PlacesServiceStatus.OK) {
      for (var i = 0; i < results.length; i++) {
        var place = results[i];
        createMarker(results[i]);
      }
    }
  }
}

// function performSearch() {
//   alert('perform seach');
//   var request = {
//     bounds: map.getBounds(),
//     location: pos
//   };
//   service.textSearch(request, callback);
// }

// function callback(results, status) {
//   if (status != google.maps.places.PlacesServiceStatus.OK) {
//     alert(status);
//     return;
//   }
//   for (var i = 0, result; result = results[i]; i++) {
//     createMarker(result);
//   }
// }

function createMarker(place) {
  var marker = new google.maps.Marker({
    map: map,
    position: place.geometry.location,
    icon: {
      //Star
      path: 'M 0,-24 6,-7 24,-7 10,4 15,21 0,11 -15,21 -10,4 -24,-7 -6,-7 z',
      fillColor: '#f25518',
      fillOpacity: 1,
      scale: 1/2,
      strokeColor: '#222222',
      strokeWeight: 2
      //url: 'http://www.lolt.org/images/header/logo.png'
    }
  });

  var contentString = '<div id="content">'+
      '<div id="siteNotice">'+
      '</div>'+
      '<p><a href="/location/' + encodeURIComponent(place.geometry.location.A) + '/' + encodeURIComponent(place.geometry.location.k) + '/' + place.vicinity + '/' + place.name + '" target="_blank">' +
      'View VStoryCorps Stories</a> '+
      '</p>'+
      '</div>'+
      '</div>';

  var infowindow = new google.maps.InfoWindow({
      content: contentString
  });

  google.maps.event.addListener(marker, 'click', function() {
    infowindow.open(map,marker);
  });
}

$('document').ready(function() {
  if (location.pathname === "/") {
    google.maps.event.addDomListener(window, 'load', initialize);
  }
});
