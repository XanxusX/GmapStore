function gmap_show(company) {
  if ((company.latitude == null) || (company.longitude == null) ) {    // validation check if coordinates are there
    return 0;
  }

  handler = Gmaps.build('Google');    // map init
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
    markers = handler.addMarkers([    // put marker method
      {
        "lat": company.latitude,    // coordinates from parameter company
        "lng": company.longitude,
        /*"picture": {    // setup marker icon
          "url": 'http://people.mozilla.com/~faaborg/files/shiretoko/firefoxIcon/firefox-32.png',
          "width":  32,
          "height": 32
        },*/
        "infowindow": "<b>" + company.name + "</b> " + company.address + ", " + company.postal_code + " " + company.city
      }
    ]);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
    handler.getMap().setZoom(15);    // set the default zoom of the map
  });
}

function gmap_form(company) {
  handler = Gmaps.build('Google');    // map init
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
    if (company && company.latitude && company.longitude) {    // statement check - new or edit view
      markers = handler.addMarkers([    // print existent marker
        {
          "lat": company.latitude,
          "lng": company.longitude,
          /*"picture": {
            "url": 'http://www.planet-action.org/img/2009/interieur/icons/orange-dot.png',
            "width":  32,
            "height": 32
          },*/
          "infowindow": "<b>" + company.name + "</b> " + company.address + ", " + company.postal_code + " " + company.city
        }
      ]);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
      handler.getMap().setZoom(15);
    }
    else {    // show the empty map
      handler.fitMapToBounds();
      handler.map.centerOn([25.056323, 121.486101]);
      handler.getMap().setZoom(15);
    }
  });

  var markerOnMap;

  function placeMarker(location) {    // simply method for put new marker on map
    if (markerOnMap) {
      markerOnMap.setPosition(location);
    }
    else {
      markerOnMap = new google.maps.Marker({
        position: location,
        map: handler.getMap()
      });
    }
  }

  google.maps.event.addListener(handler.getMap(), 'click', function(event) {    // event for click-put marker on map and pass coordinates to hidden fields in form
    placeMarker(event.latLng);
    document.getElementById("map_lat").value = event.latLng.lat();
    document.getElementById("map_lng").value = event.latLng.lng();
  });
}

function gmap_index(hash) {
  handler = Gmaps.build('Google');
  handler.buildMap({
      provider: {
        disableDefaultUI: true
        // pass in other Google Maps API options here
      },
      internal: {
        id: 'map'
      }
    },
    function(){
      markers = handler.addMarkers(hash);
      handler.bounds.extendWith(markers);
      handler.fitMapToBounds();
    }
  );
}
