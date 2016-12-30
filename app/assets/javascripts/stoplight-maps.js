$(function() {
  if ($('.js-mapbox').length > 0) {
    mapboxgl.accessToken = window.mapboxAccessToken;
    var map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/light-v9',
      center: [-118.4738875, 34.028258],
      zoom: 13
    });

    map.addControl(new mapboxgl.Geolocate({position: 'top-left'}));
    map.addControl(new mapboxgl.Navigation({position: 'top-right'}));
    //map.addControl(new mapboxgl.Attribution({position: 'bottom-right'}));

    var initializeMapLayerButton = function(name, id) {
      var link = document.createElement('a');
      link.href = '#';
      link.className = 'active';
      link.textContent = name;

      link.onclick = function (e) {
        e.preventDefault();
        e.stopPropagation();

        var visibility = map.getLayoutProperty(id, 'visibility');

        if (visibility === 'visible') {
          map.setLayoutProperty(id, 'visibility', 'none');
          this.className = '';
        } else {
          this.className = 'active';
          map.setLayoutProperty(id, 'visibility', 'visible');
        }
      };

      var layers = document.getElementById('menu');
      layers.appendChild(link);
    };

    map.on('load', function () {
      map.addSource('stoplight_circles', {
        type: 'geojson',
        data: '/api/v1/commuting/circle_geojson?per_page=1000'
      });

      map.addLayer({
        "id": "stoplight_circles",
        "type": "fill",
        "source": "stoplight_circles",
        "layout": {
          "visibility": "visible"
        },
        "paint": {
          'fill-color': '#088',
          'fill-opacity': 0.3
        }
      });

      map.addSource('stoplights', {
        type: 'geojson',
        data: '/api/v1/commuting/geojson?per_page=1000'
      });

      map.addLayer({
        "id": "stoplights",
        "type": "circle",
        "source": "stoplights",
        "layout": {
          "visibility": "visible",
        },
        paint: {
          "circle-color": {
            property: 'average_stop_duration',
            stops: [
              [0, 'blue'],
              [10, 'green'],
              [30, 'yellow'],
              [60, 'red']
            ]
          },
          "circle-radius": {
            property: 'count',
            stops: [
              [1, 3],
              [10, 4],
              [20, 5]
            ]
          }
        }
      });

      var gradientLevels = [
        { color: 'red',
          minThreshold: 100 },
        { color: 'yellow',
          minThreshold: 50 },
        { color: 'green',
          minThreshold: 0 }
      ];

      //gradientLevels.forEach(function(level, i) {
      //  map.addLayer({
      //    "id": "stoplights-heatmap-" + i,
      //    "type": "circle",
      //    "source": "stoplights",
      //    "paint": {
      //      "circle-color": layer.color,
      //      "circle-radius": 70,
      //      "circle-blur": 1
      //    },
      //    "filter": i === layers.length - 1 ?
      //      [">=", "cluster_count", layers] :
      //      []
      //  });
      //});

    });

    initializeMapLayerButton('Debug', 'stoplight_circles');
    initializeMapLayerButton('Stoplights', 'stoplights');

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
      .setHTML('Total stops: ' + feature.properties.count + ', average wait: ' +
               feature.properties.average_stop_duration + ' seconds')
      .addTo(map);
    });

    // Use the same approach as above to indicate that the symbols are clickable
    // by changing the cursor style to 'pointer'.
    map.on('mousemove', function (e) {
      var features = map.queryRenderedFeatures(e.point, { layers: ['stoplights'] });
      map.getCanvas().style.cursor = (features.length) ? 'pointer' : '';
    });

    // Reverse geoIP lookup for map center from this browser
    jQuery.ajax({
      url: '//freegeoip.net/json/',
      type: 'POST',
      dataType: 'jsonp',
      success: function(location) {
        console.log(location);
        map.setCenter([location.longitude, location.latitude]);
      }
    });
  }
});
