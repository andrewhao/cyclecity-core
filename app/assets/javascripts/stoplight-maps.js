$(function() {
  if ($('.js-mapbox').length > 0) {
    mapboxgl.accessToken = window.mapboxAccessToken;
    var map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v9',
      center: [-118.4738875, 34.028258],
      zoom: 13
    });

    map.addControl(new mapboxgl.Geolocate({position: 'top-left'}));
    map.addControl(new mapboxgl.Navigation({position: 'top-right'}));
    //map.addControl(new mapboxgl.Attribution({position: 'bottom-right'}));

    map.on('load', function () {
      map.addSource('stoplights', {
        type: 'geojson',
        data: '/api/v1/commuting/geojson?per_page=1000'
      });

      map.addLayer({
        "id": "stoplights",
        "type": "symbol",
        "source": "stoplights",
        "layout": {
          "icon-image": "marker-15",
					"icon-allow-overlap": true
        }
      });
    });

		// When a click event occurs near a marker icon, open a popup at the location of
		// the feature, with description HTML from its properties.
		map.on('click', function (e) {
			var features = map.queryRenderedFeatures(e.point, { layers: ['stoplights'] });

			if (!features.length) {
				return;
			}

			var feature = features[0];

			// Populate the popup and set its coordinates
			// based on the feature found.
			var popup = new mapboxgl.Popup()
			.setLngLat(feature.geometry.coordinates)
			.setHTML('Total stops: ' + feature.properties.count)
			.addTo(map);
		});

		// Use the same approach as above to indicate that the symbols are clickable
		// by changing the cursor style to 'pointer'.
		map.on('mousemove', function (e) {
			var features = map.queryRenderedFeatures(e.point, { layers: ['stoplights'] });
			map.getCanvas().style.cursor = (features.length) ? 'pointer' : '';
		});
  }
});
