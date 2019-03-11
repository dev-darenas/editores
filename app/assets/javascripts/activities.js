var map = null;

$(document).ready(function () {


  $.ajax({
    url: "/activities.js",
    type: "GET",
    data: {
      user_id: $("#user_id").val(),
      date: $("#date").val()
    }
  });
})

function addMarker(latitude, longitude, map, type, client_name) {
  var coords = new google.maps.LatLng(latitude, longitude);
  var marker = new google.maps.Marker({
    position: coords,
    map:map,
    animation: google.maps.Animation.DROP,
    label: {
      fontWeight: 'bold',
      text: client_name,
    },
    icon: {
      labelOrigin: new google.maps.Point(20, -15),
      url: type == 'order' ? "http://maps.google.com/mapfiles/ms/icons/red-dot.png" : "http://maps.google.com/mapfiles/ms/icons/blue-dot.png",
      size: new google.maps.Size(32, 40),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(11, 40),
    }
  });
  map.setCenter(coords)
}