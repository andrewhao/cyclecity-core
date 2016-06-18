$(function() {
  if ($('.js-mapbox').length > 0) {
    mapboxgl.accessToken = 'pk.eyJ1IjoiYW5kcmV3aGFvIiwiYSI6IndWNDBXRkkifQ.Cge0ieORVxF2tPArcg0c6g';
    var map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v9',
      center: [-96, 37.8],
      zoom: 3
    });

		var stoplightGeoJSON = {
			"type": "FeatureCollection",
			"features": [{
				"type": "Feature",
				"geometry": {
					"type": "Point",
					"coordinates": [-77.03238901390978, 38.913188059745586]
				},
				"properties": {
					"title": "Mapbox DC",
					"marker-symbol": "monument"
				}
			}, {
				"type": "Feature",
				"geometry": {
					"type": "Point",
					"coordinates": [-122.414, 37.776]
				},
				"properties": {
					"title": "Mapbox SF",
					"marker-symbol": "harbor"
				}
			}]
		};

    map.on('load', function () {
      map.addSource('stoplights', {
        type: 'geojson',
        data: stoplightGeoJSON
      });

      map.addLayer({
        "id": "stoplights",
        "type": "symbol",
        "source": "stoplights",
        "layout": {
          "icon-image": "{marker-symbol}-15",
          "text-field": "{title}",
          "text-font": ["Open Sans Semibold", "Arial Unicode MS Bold"],
          "text-offset": [0, 0.6],
          "text-anchor": "top"
        }
      });
    });
  };
});
