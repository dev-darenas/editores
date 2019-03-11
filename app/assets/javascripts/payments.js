function initMap(order_lat, order_lng, payment_lat, payment_lng) {
  var orderCoords = new google.maps.LatLng(order_lat, order_lng);
  var paymentCoords = new google.maps.LatLng(payment_lat, payment_lng);

  var mapOptions = {
    center: orderCoords,
    zoom: 14
  };

  var map = new google.maps.Map(document.getElementById('map'), mapOptions);

  var orderMarker = new google.maps.Marker({
      position: orderCoords,
      map: map,
      animation: google.maps.Animation.DROP,
      label: {
        fontWeight: 'bold',
        text: 'Cliente',
      },
      icon: {
        labelOrigin: new google.maps.Point(20, -15),
        url: "http://maps.google.com/mapfiles/ms/icons/red-dot.png",
        size: new google.maps.Size(32, 40),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(11, 40),
      }
  });

  var paymentMarker = new google.maps.Marker({
      position: paymentCoords,
      map: map,
      animation: google.maps.Animation.DROP,
      label: {
        fontWeight: 'bold',
        text: 'Cobro',
      },
      icon: {
        labelOrigin: new google.maps.Point(20, -15),
        url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png",
        size: new google.maps.Size(32, 40),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(11, 40),
      }
  });
}