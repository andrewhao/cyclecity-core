$(function() {
  if ($('.js-mapbox').length > 0) {
    mapboxgl.accessToken = 'pk.eyJ1IjoiYW5kcmV3aGFvIiwiYSI6IndWNDBXRkkifQ.Cge0ieORVxF2tPArcg0c6g';
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
          "text-field": "{title}",
          "text-font": ["Open Sans Semibold", "Arial Unicode MS Bold"],
          "text-offset": [0, 0.6],
          "text-anchor": "top"
        }
      });
    });
  };
});
